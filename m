Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 6965370FEFC
	for <lists+qemu-devel@lfdr.de>; Wed, 24 May 2023 22:11:08 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1q1unh-0008RA-Jk; Wed, 24 May 2023 16:09:37 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1q1unf-0008R2-OV
 for qemu-devel@nongnu.org; Wed, 24 May 2023 16:09:35 -0400
Received: from mail-pg1-x531.google.com ([2607:f8b0:4864:20::531])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1q1und-0003Bz-SV
 for qemu-devel@nongnu.org; Wed, 24 May 2023 16:09:35 -0400
Received: by mail-pg1-x531.google.com with SMTP id
 41be03b00d2f7-52867360efcso558666a12.2
 for <qemu-devel@nongnu.org>; Wed, 24 May 2023 13:09:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1684958972; x=1687550972;
 h=content-transfer-encoding:subject:from:cc:to:content-language
 :user-agent:mime-version:date:message-id:from:to:cc:subject:date
 :message-id:reply-to;
 bh=vzWfapRqWf1J7ulEfahuGQQiOOxlJodOrEc7Xqm1JYo=;
 b=rTaaN1/GPYDDzWTRAv6DALU4omzmBoPcMDXzQxgCIFxqVLn7owPPp2nsRG+Zyt2fwG
 IpwsVEc5+ZF+xiiBKgoEVZC+pFr1KAW5powg8pswVu+9/d17EqH/sRAHShztJHLjL0+3
 T3a+98d5tBoO+SL306t35CrcajY5gTjy7Vyh5rIN9alznVJUnRvc33Rpx19q+MGuZRVU
 KiJgT16r/OplMqedaIGLhYNdIF9GEAzod0xtGZtGhhrITMeoDuz+gRFXlWBFfK7DkyM0
 L7G69Npk8cOus6bZ11uJVrr+pf7YPp6y44Ty+K6GWH4P6abd4v8TRM3nletRAzobY1hi
 soFA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1684958972; x=1687550972;
 h=content-transfer-encoding:subject:from:cc:to:content-language
 :user-agent:mime-version:date:message-id:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=vzWfapRqWf1J7ulEfahuGQQiOOxlJodOrEc7Xqm1JYo=;
 b=jVnQ/f+hVE/nVZuJSHd3ZE2NB6fqgnpyCcaRDJb7jOZ42pz34+RDxj2mZaj6qlk4sC
 dQyvAsg7bTQyxKweU9/v3ELkK0pwoJYOoBE6/d5AV3oBp40gzBae0e5C30PY86dmgwGH
 qwGtZgYWuiyQ2WQOZYjCKMw5XBZmM2mPTxbIdBo8wxsJQI74WBpSVU7zjFor5IdVNQhY
 iAEG1KUviHn/Cf+4mPWTuuw0TZfCPXU+6AFd2YZP4nf8Ts4CgQe0jo0pHrve6hea9pgq
 FjcpassL3YRWt4YA/4ihNfc6ssEveDFmEDfd9zHsMt8H7y3qo8sX9cfvlidchwOEYSDO
 QCyg==
X-Gm-Message-State: AC+VfDyW++NprlEW3jkKef7hQcY5acWFBJZI3zgospsTEsnZkR2IlbLb
 A3/FzcKPLshrrd7/0ZJr0ZACV7QkGfHTivTYRyo=
X-Google-Smtp-Source: ACHHUZ6ncfEHPDDF9n5/uiULtTBTpiu7TSd1Z31g+/N24gZlxD5QEPXu4OmfPu7u8iNaSsNCRINcPg==
X-Received: by 2002:a17:903:1112:b0:1aa:f818:7a23 with SMTP id
 n18-20020a170903111200b001aaf8187a23mr21022372plh.27.1684958972490; 
 Wed, 24 May 2023 13:09:32 -0700 (PDT)
Received: from ?IPV6:2602:ae:1598:4c01:6b03:9af2:33c1:3d6b?
 ([2602:ae:1598:4c01:6b03:9af2:33c1:3d6b])
 by smtp.gmail.com with ESMTPSA id
 l12-20020a170902d34c00b001a63ba28052sm9149901plk.69.2023.05.24.13.09.31
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 24 May 2023 13:09:32 -0700 (PDT)
Message-ID: <b7ef4d65-1b2c-c435-b448-9b6bec39cd96@linaro.org>
Date: Wed, 24 May 2023 13:09:30 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.0
Content-Language: en-US
To: Eldon Stegall <eldon-qemu@eldondev.com>
Cc: qemu-devel <qemu-devel@nongnu.org>
From: Richard Henderson <richard.henderson@linaro.org>
Subject: New container build error: mountpoint does not exit
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::531;
 envelope-from=richard.henderson@linaro.org; helo=mail-pg1-x531.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Errors-To: qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org
Sender: qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org

Hi Eldon,

New this morning are some odd failures in the container build stage, e.g

https://gitlab.com/qemu-project/qemu/-/jobs/4345796216#L235

cgroups: cgroup mountpoint does not exist: unknown

There are several such failures in that pipeline. I've not seen this before, nor was it 
happening yesterday.

Any ideas?


r~

