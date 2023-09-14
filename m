Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 99E8079FD8B
	for <lists+qemu-devel@lfdr.de>; Thu, 14 Sep 2023 09:54:35 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qghA2-0000tX-NI; Thu, 14 Sep 2023 03:53:14 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <akihiko.odaki@daynix.com>)
 id 1qghA1-0000rk-B3
 for qemu-devel@nongnu.org; Thu, 14 Sep 2023 03:53:13 -0400
Received: from mail-pf1-x433.google.com ([2607:f8b0:4864:20::433])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <akihiko.odaki@daynix.com>)
 id 1qgh9z-00023s-Nm
 for qemu-devel@nongnu.org; Thu, 14 Sep 2023 03:53:13 -0400
Received: by mail-pf1-x433.google.com with SMTP id
 d2e1a72fcca58-68fdcc37827so1335536b3a.0
 for <qemu-devel@nongnu.org>; Thu, 14 Sep 2023 00:53:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=daynix-com.20230601.gappssmtp.com; s=20230601; t=1694677989; x=1695282789;
 darn=nongnu.org; 
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=27m7RKhA6s1+Ji4kGUMiSKZBO9rQhPfJMrOyCvOmsyY=;
 b=J7bgPKQRC1Ed19aUF29VFg9ghGknmt0n12Xtss1odGCR7/9CLbAmz8VPHlObG896hb
 GRkC2NYg6GDz60BjtIjVD3FBLv2Y1j/aCOVltolzWPIitChrbWtyTM96wJ3wS1jJMHOo
 zBbTuCzOb4RNg6Bc/SjMv3KwKd1AHvFMHnGfIZdPRY1LEzX5IBgKfK8KXzmS933H71fh
 FaSI+cnO8nUIBDOluw3uXOQX0BRYjS7+kuH/djDDudGi3KcrZCDwiuhprDc+Z5RyvYLi
 OAbR0Ec5FmY+97gwv2r43ThMD+SZjr/gKbccDYM2fNNTlZ9j0rejsVemaTYnAuI3rrve
 ceNA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1694677989; x=1695282789;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=27m7RKhA6s1+Ji4kGUMiSKZBO9rQhPfJMrOyCvOmsyY=;
 b=h0M1cl06VwGAw56yAQf0Bb0Vkn7ERSE0nihL+OOuWGhKGAq5gn/tkxk454R1e6HMAv
 Mw8iXO4GJQrPtd84elnekAehK8YbIz1hNQVb5+cvEEfOgyQ2duKRsJlPPDW94RLfi5e6
 Nn8vMaBe6oz6MfyoWCV+534KrE6SMwyjDDwVJVeRhFjSbvzT0o2oNQmCbD/sTlL8UncD
 N5eOOvvVnNWNDfpmigC7MCq1l03++oTy16xeAg0fXsqhKWEha0ZrH0PBMJtFEHxX25iY
 +Cxk2rABdgB5yVj0iANjs9zZjCXxdXYPQoQ5ETf4UBTp7q0dlb5/RF4Q27wUNLZC2Jef
 miDA==
X-Gm-Message-State: AOJu0YyPKNG/8LeV3ai6/6tfWURyQB9/812SMUOWquIF1SIkTr/C7+Pb
 PNAP36sacSp+Hr+oAR+0kZfXWg==
X-Google-Smtp-Source: AGHT+IEj3GAyPAey8hi5evVeDoIXR6SBZu+pq83IRRUXH1xhGfYKzQwwb0aiqTa4WwXmCTsqS2KLUw==
X-Received: by 2002:a05:6a20:9154:b0:159:e4ab:15ce with SMTP id
 x20-20020a056a20915400b00159e4ab15cemr1577439pzc.15.1694677989154; 
 Thu, 14 Sep 2023 00:53:09 -0700 (PDT)
Received: from ?IPV6:2400:4050:a840:1e00:78d2:b862:10a7:d486?
 ([2400:4050:a840:1e00:78d2:b862:10a7:d486])
 by smtp.gmail.com with ESMTPSA id
 13-20020aa7914d000000b00688965c5227sm744541pfi.120.2023.09.14.00.53.07
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 14 Sep 2023 00:53:08 -0700 (PDT)
Message-ID: <a391f008-f369-420d-a16d-7149d21998b5@daynix.com>
Date: Thu, 14 Sep 2023 16:53:06 +0900
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 5/5] elf2dmp: rework PDB_STREAM_INDEXES::segments obtaining
Content-Language: en-US
To: Viktor Prutyanov <viktor@daynix.com>, annie.li@oracle.com,
 kkostiuk@redhat.com
Cc: qemu-devel@nongnu.org, peter.maydell@linaro.org, yan@daynix.com,
 viktor.prutyanov@phystech.edu
References: <20230913224657.11606-1-viktor@daynix.com>
 <20230913224657.11606-6-viktor@daynix.com>
From: Akihiko Odaki <akihiko.odaki@daynix.com>
In-Reply-To: <20230913224657.11606-6-viktor@daynix.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: none client-ip=2607:f8b0:4864:20::433;
 envelope-from=akihiko.odaki@daynix.com; helo=mail-pf1-x433.google.com
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_NONE=0.001 autolearn=ham autolearn_force=no
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

On 2023/09/14 7:46, Viktor Prutyanov wrote:
> PDB for Windows 11 kernel has slightly different structure compared to
> previous versions. Since elf2dmp don't use the other fields, copy only
> 'segments' field from PDB_STREAM_INDEXES.

I suggest replacing the sidx member of struct pdb_reader with a single 
uint16_t to save some space and prevent accidentally introducing 
references to other members.

