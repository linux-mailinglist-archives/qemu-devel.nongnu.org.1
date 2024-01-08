Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 9D273826C38
	for <lists+qemu-devel@lfdr.de>; Mon,  8 Jan 2024 12:09:48 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rMnVZ-00034q-Cc; Mon, 08 Jan 2024 06:09:29 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1rMnVX-00034a-NL
 for qemu-devel@nongnu.org; Mon, 08 Jan 2024 06:09:27 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1rMnVV-0003qd-L2
 for qemu-devel@nongnu.org; Mon, 08 Jan 2024 06:09:27 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1704712165;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=+Ip1S/VBA8XutHSmv+yzD7EkpSzeTIPibp5CdRW/vMc=;
 b=BKIzBGp5eqYTStXc254LJP31bCVFmUWOxkoloZlrGDrL1LdJoCDkBmnrOQZnLsdeFQyy06
 4qM7Gi+84Qt26FHxpidd35FvTQIz72Y4p089wJ9NNoLbon2kGNglHYZScjxW09UJM1QTwm
 9iW3DRMtCwfNC+WRk3IFNgeH1q47Sb0=
Received: from mail-oi1-f199.google.com (mail-oi1-f199.google.com
 [209.85.167.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-527-PzYcLhMrMGCctLyu4dOu3w-1; Mon, 08 Jan 2024 06:09:23 -0500
X-MC-Unique: PzYcLhMrMGCctLyu4dOu3w-1
Received: by mail-oi1-f199.google.com with SMTP id
 5614622812f47-3bd24849608so2077404b6e.2
 for <qemu-devel@nongnu.org>; Mon, 08 Jan 2024 03:09:23 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1704712163; x=1705316963;
 h=content-transfer-encoding:in-reply-to:autocrypt:from:references:cc
 :to:content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=+Ip1S/VBA8XutHSmv+yzD7EkpSzeTIPibp5CdRW/vMc=;
 b=A0/EI4Juzl2Dwc16yaJ9d38WIMqcL+quiC8pfE9nVn72s+8fBOH9nmw30vpE8EQAPr
 jQqhC/uWA74Oq4elKcyJkMXTT8qKCQvfUTBklaT2RI27Yym5a/ro3fsh2DzRkxQSiQQP
 IFUSTqv0ZL2MhoeY9JIRldSg+bdHb2BvUX1OHIGojI9EwkeOn7ONQOc+7/GxrbfH5iRz
 mzaQL1e8uZ5JgyyHA19yheqccw3altHNRcmLcokpJFmROo//XiIyAhv3+vuBS/f7NXDe
 lI7Y34fw22sBBk+2n1/ZISz7IyKKSrx/Hh0GDK6FuZ5183QRZ4ifkPKQ/UHfUheKIsSt
 SJaQ==
X-Gm-Message-State: AOJu0YxZ0HI6Zm67PklVqY6FyWxHgBZQCQ7hZgfks8quq1d+eBUM3m0u
 e3hd56bJj5PcLnuixQJqQ42aCSn7W8Csj7VabVfcFv9N8SEi7ZwFJDrwv4MLdwteCUjP7qLJgOE
 r5hyBXZ+EgfUNMuLuLd7JDME=
X-Received: by 2002:a05:6808:189c:b0:3bd:3381:ee3e with SMTP id
 bi28-20020a056808189c00b003bd3381ee3emr765646oib.57.1704712163062; 
 Mon, 08 Jan 2024 03:09:23 -0800 (PST)
X-Google-Smtp-Source: AGHT+IFrsFJJJ18f1UYstKzkam505QcF2wSQt4p6+GXtQ4GjyG9KbVAkgi2ovH912qxVAcrpmM5qRA==
X-Received: by 2002:a05:6808:189c:b0:3bd:3381:ee3e with SMTP id
 bi28-20020a056808189c00b003bd3381ee3emr765637oib.57.1704712162852; 
 Mon, 08 Jan 2024 03:09:22 -0800 (PST)
Received: from [192.168.0.9] (ip-109-43-179-78.web.vodafone.de.
 [109.43.179.78]) by smtp.gmail.com with ESMTPSA id
 l10-20020ad4444a000000b0067f4507b64dsm2729552qvt.63.2024.01.08.03.09.20
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 08 Jan 2024 03:09:22 -0800 (PST)
Message-ID: <a8c05fb1-7409-4dba-910f-8fdd315d06d7@redhat.com>
Date: Mon, 8 Jan 2024 12:09:18 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 1/4] linux-headers: drop pvpanic.h
Content-Language: en-US
To: =?UTF-8?Q?Thomas_Wei=C3=9Fschuh?= <thomas@t-8ch.de>,
 "Michael S. Tsirkin" <mst@redhat.com>, Cornelia Huck <cohuck@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>, Laurent Vivier <lvivier@redhat.com>
Cc: qemu-devel@nongnu.org
References: <20240107-pvpanic-shutdown-v4-0-81500a7e4081@t-8ch.de>
 <20240107-pvpanic-shutdown-v4-1-81500a7e4081@t-8ch.de>
From: Thomas Huth <thuth@redhat.com>
Autocrypt: addr=thuth@redhat.com; keydata=
 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
In-Reply-To: <20240107-pvpanic-shutdown-v4-1-81500a7e4081@t-8ch.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.129.124; envelope-from=thuth@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -26
X-Spam_score: -2.7
X-Spam_bar: --
X-Spam_report: (-2.7 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-2.098,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=-0.01, RCVD_IN_MSPIKE_WL=-0.01,
 RCVD_IN_SORBS_WEB=1.5, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
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

On 07/01/2024 15.05, Thomas Weißschuh wrote:
> misc/pvpanic.h from the Linux UAPI does not define a Linux UAPI but a
> qemu device API.
> 
> This leads to a weird process when updates to the interface are needed:
> 1) Change to the specification in the qemu tree
> 2) Change to the header in the Linux tree
> 3) Re-import of the header into Qemu.
> 
> The kernel prefers to drop the header anyways.
> 
> Prepare for the removal from the Linux UAPI headers by moving the
> contents to the existing pvpanic.h header.
> 
> Link: https://lore.kernel.org/lkml/2023110431-pacemaker-pruning-0e4c@gregkh/
> Signed-off-by: Thomas Weißschuh <thomas@t-8ch.de>
> ---
>   hw/misc/pvpanic-isa.c                    | 1 -
>   hw/misc/pvpanic-pci.c                    | 1 -
>   hw/misc/pvpanic.c                        | 1 -
>   include/hw/misc/pvpanic.h                | 3 +++
>   include/standard-headers/linux/pvpanic.h | 9 ---------
>   scripts/update-linux-headers.sh          | 3 +--
>   6 files changed, 4 insertions(+), 14 deletions(-)

Reviewed-by: Thomas Huth <thuth@redhat.com>


