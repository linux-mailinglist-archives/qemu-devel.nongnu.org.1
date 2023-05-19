Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id B497770A2E2
	for <lists+qemu-devel@lfdr.de>; Sat, 20 May 2023 00:46:27 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1q08qG-0000V7-4u; Fri, 19 May 2023 18:44:56 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1q08qD-0000Uq-Ru
 for qemu-devel@nongnu.org; Fri, 19 May 2023 18:44:53 -0400
Received: from mail-pl1-x62d.google.com ([2607:f8b0:4864:20::62d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1q08qC-0003j9-9u
 for qemu-devel@nongnu.org; Fri, 19 May 2023 18:44:53 -0400
Received: by mail-pl1-x62d.google.com with SMTP id
 d9443c01a7336-1ae4c5e12edso30058685ad.3
 for <qemu-devel@nongnu.org>; Fri, 19 May 2023 15:44:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1684536290; x=1687128290;
 h=content-transfer-encoding:subject:from:to:content-language
 :user-agent:mime-version:date:message-id:from:to:cc:subject:date
 :message-id:reply-to;
 bh=xKViF/D12vn0WxmZHPQI5TLgxwJ3EHyzvByaH5IdIH0=;
 b=WoiwL4/eJpWFD1TsTAQG71R8PJEuWp1cMxGISTgpgSGSumFD/sTasYEcYroHaINiU/
 Lkx4Ll+vWbb+H+X4XwXvwSKayRJXAb5BTVT0+Sxj3IpdhpMMhcDg0cmTH46kxo3juUhv
 J26bQLkARCecM2OujZI5lJihCaZOkl88mMnLFNbHvPRAp5e7dHpFXxqLyBmXNoddoiWC
 RO6jPpXFCSvky0I+RGNAnksejTll0ibokwrmdpoq0N/hUWgrvVQ3A/ZeZnCqofjQYuXc
 KK7CUXO25ZKfIWDIjGbHUPvmD1oSabtKiMYTQ9TURTlAYu//HaTbR7I+DM8qGbHnXkO1
 tn3Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1684536290; x=1687128290;
 h=content-transfer-encoding:subject:from:to:content-language
 :user-agent:mime-version:date:message-id:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=xKViF/D12vn0WxmZHPQI5TLgxwJ3EHyzvByaH5IdIH0=;
 b=LOHmNLH5VbXWHeGB9uo4Ua/p66dgDvU9rfhzPmpSfpCZfJ1y224YMdE9AvfSuFhaKc
 9lGPAkTbEut4/d8NksRErvZY6/JbtG69hA9v8sA5BzmzBZb+CHZjGJhikwH05ETW6QZx
 h7ZRghl/rxZif4X7CisJb2qt8wUyn5VpigcymHAOnFtsr62mGtGhI9yZaIYmFA/XwNny
 Crhso93efX4w0HIlSow1b6pB/3fLNwXg+CyGOidnnhJXZ+V9Lw/j2qENhCbREAv6UbS6
 +c7Cw1o4DSYe/C7GmguhVMcDbSTl+8W25GLVsPud6tg2lAfXd46rqzv16VL5e15lDXpc
 cZ+w==
X-Gm-Message-State: AC+VfDzb4u8PYYYmKQd5TOjM6XgcorRinnr55MHZP7DsViuzWV+Xv9R3
 SwJ43dCzLffBP3EILqoF0Rr8rAThCSLF/0a5YUw=
X-Google-Smtp-Source: ACHHUZ4aBi4vVeNO2rGtrCoAcFxyDKVWJgfep4QQXGfJUJU4OhM7Yng9X3vs08N+bZ/XGvrvQXLt0g==
X-Received: by 2002:a17:902:778c:b0:1ae:5bd0:d452 with SMTP id
 o12-20020a170902778c00b001ae5bd0d452mr3732232pll.26.1684536290506; 
 Fri, 19 May 2023 15:44:50 -0700 (PDT)
Received: from ?IPV6:2602:ae:1598:4c01:686f:d1bb:8fc4:dc38?
 ([2602:ae:1598:4c01:686f:d1bb:8fc4:dc38])
 by smtp.gmail.com with ESMTPSA id
 x4-20020a170902ea8400b001a1adbe215asm133761plb.142.2023.05.19.15.44.49
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 19 May 2023 15:44:50 -0700 (PDT)
Message-ID: <7b1805ad-56fd-77f7-48f7-fdf80f6a2e5b@linaro.org>
Date: Fri, 19 May 2023 15:44:48 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.0
Content-Language: en-US
To: qemu-devel <qemu-devel@nongnu.org>
From: Richard Henderson <richard.henderson@linaro.org>
Subject: io-qcow2 failures on zfs
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::62d;
 envelope-from=richard.henderson@linaro.org; helo=mail-pl1-x62d.google.com
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

I'm doing some testing on one of the Linaro build machines and I reliably see

Summary of Failures:

712/790 qemu:block / io-qcow2-150                                                 ERROR 
        5.24s   exit status 1
777/790 qemu:block / io-qcow2-copy-before-write                                   ERROR 
       16.31s   exit status 1
779/790 qemu:block / io-qcow2-244                                                 ERROR 
       37.10s   exit status 1

This is x86_64 ubuntu 22.04, same as my laptop, so the only thing I can think is the 
filesystem type:

hackpool-0/home/richard.henderson /home/richard.henderson zfs 
rw,nosuid,nodev,noatime,xattr,noacl 0 0

Any thoughts?


r~

