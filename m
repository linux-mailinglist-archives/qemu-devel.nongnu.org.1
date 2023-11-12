Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 49AC77E91BE
	for <lists+qemu-devel@lfdr.de>; Sun, 12 Nov 2023 18:06:27 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1r2DuC-0002sV-6u; Sun, 12 Nov 2023 12:05:52 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1r2Du9-0002sI-50
 for qemu-devel@nongnu.org; Sun, 12 Nov 2023 12:05:49 -0500
Received: from mail-ej1-x632.google.com ([2a00:1450:4864:20::632])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1r2Du6-0004jS-Mp
 for qemu-devel@nongnu.org; Sun, 12 Nov 2023 12:05:48 -0500
Received: by mail-ej1-x632.google.com with SMTP id
 a640c23a62f3a-9c3aec5f326so974314366b.1
 for <qemu-devel@nongnu.org>; Sun, 12 Nov 2023 09:05:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1699808735; x=1700413535; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=e1LL1AlY9N/DGsRY7ciImhvPT3QgMB/hvHzet9kH5Yw=;
 b=pYU8pIiapXpz47vThyuMIbvuDNva++28ssaTNFtLj2GxRN035hMtdac15TH6ECACol
 sA3nuYx1X+jhd8b3LcZlqIPFUnX2ipG/O855cBnfeUpQhBzcObYPYVCbu3ZrE3VO67bt
 KXgn14CEthdNdjw4bWh3r575H8FfOxNNCEzkmwFGqZEKxANgoxuJ9uO/LME7zjAHJNkU
 A6HFO1aEhPbAsqJBWRViRtSWy4fQGmfzoOekttHjvGUMHwZ/xcURRf7xljYqxNL9id/E
 RFpdU7IJXLe1F+OINGxNj15zEtGiHFi84jsJkJJxP8QXhkegKdT4fP535NYD5MpCKCFK
 IIog==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1699808735; x=1700413535;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=e1LL1AlY9N/DGsRY7ciImhvPT3QgMB/hvHzet9kH5Yw=;
 b=LCjc0O/8WUDy06ijAD2gUExsvvmR+r+cqqi/E4y+omNuAQyjSZ3ao69vDaN2l4yiZi
 bmm2fju0aofHRZO6LAmYfbSRWMLsod6ifkBMouBkA8F5BaqfvB4wy16emomiQuUwrJLW
 cORM+mmgH701wmTUg32j4cUT7a+4uMHiohgGIrx7JKxb4dCp0C5s3RrjZEDA4OGeBOXy
 5VCfjgByurrlmkSYGSUeqiK8JxTqTu2fo84QQseAm/UrkvKgAaglVNuDkNcFNEu7OkRo
 YywT6M3/zVOuGYsKcXkh418mhB2dOQ8q3DEQu1MsNdXhhGnK88B312kEkYk5dUBiVDFI
 8QRQ==
X-Gm-Message-State: AOJu0YyQpp7m1Udvl/xQuhVwWCBzJtFSzHgtwqIojxEAyY7bJSj7Uyzr
 opsNEzGtuwj2rOfvY+gwTUg/8A==
X-Google-Smtp-Source: AGHT+IGEbeC27kVfHg1Sgk6mF1K9cZysDVNdU19ISd+1b2iVrO6towIuaqKWwDKPhY02rywfZY/l1g==
X-Received: by 2002:a17:907:9728:b0:9e8:2441:5cd4 with SMTP id
 jg40-20020a170907972800b009e824415cd4mr3244044ejc.17.1699808734884; 
 Sun, 12 Nov 2023 09:05:34 -0800 (PST)
Received: from [192.168.69.100]
 (i15-lef02-th2-89-83-217-202.ft.lns.abo.bbox.fr. [89.83.217.202])
 by smtp.gmail.com with ESMTPSA id
 fj10-20020a1709069c8a00b009e7e7c0d1a9sm2129915ejc.185.2023.11.12.09.05.33
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Sun, 12 Nov 2023 09:05:34 -0800 (PST)
Message-ID: <a8d30a85-389e-442e-8dc0-dfec07107bc1@linaro.org>
Date: Sun, 12 Nov 2023 18:05:32 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 01/11] target/hppa: Update to SeaBIOS-hppa version 11
Content-Language: en-US
To: deller@gmx.de, Richard Henderson <richard.henderson@linaro.org>
Cc: qemu-devel@nongnu.org
References: <20231111013212.229673-1-richard.henderson@linaro.org>
 <20231111013212.229673-2-richard.henderson@linaro.org>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <20231111013212.229673-2-richard.henderson@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2a00:1450:4864:20::632;
 envelope-from=philmd@linaro.org; helo=mail-ej1-x632.google.com
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

Hi Helge,

On 11/11/23 02:32, Richard Henderson wrote:
> From: Helge Deller <deller@gmx.de>
> 
> New SEABIOS_HPPA_VERSION 11
> (current master branch)
> 
> Fixes and enhancements (mostly to enable 64-bit Linux kernel):
> ....
> temporary commit

What information should go here?

> Signed-off-by: Helge Deller <deller@gmx.de>
> ---
>   pc-bios/hppa-firmware.img | Bin 755480 -> 681132 bytes
>   roms/seabios-hppa         |   2 +-
>   2 files changed, 1 insertion(+), 1 deletion(-)

