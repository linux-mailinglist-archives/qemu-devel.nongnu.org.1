Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id E3EE17AF9C8
	for <lists+qemu-devel@lfdr.de>; Wed, 27 Sep 2023 07:04:21 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qlMiF-0005ZQ-2L; Wed, 27 Sep 2023 01:03:51 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1qlMiC-0005ZH-7P
 for qemu-devel@nongnu.org; Wed, 27 Sep 2023 01:03:48 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1qlMi9-0002BA-C5
 for qemu-devel@nongnu.org; Wed, 27 Sep 2023 01:03:47 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1695791023;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=aWf/XtDJ6lWldjTJi7BhDN6gyWzLnfK6MWustL4P2TY=;
 b=KyXMN7mZlS3DO+aBgpneTKMCOw04cCOns443UFi31lPBNG6irhrwkhY0UDcVWbfgI1gAKU
 oWZc+ihs5lQFz1fPlAk5NFxr5DhX0aAerYLAzXkSqd04pJFdJC12rcFFhyW+oLtQeDt5m0
 FG4LnOm8Ny/mi0TCyVsLWysXDxlP4q8=
Received: from mail-qt1-f198.google.com (mail-qt1-f198.google.com
 [209.85.160.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-355-wKtHEQ6SO6CYBP6RA3pmKQ-1; Wed, 27 Sep 2023 01:03:41 -0400
X-MC-Unique: wKtHEQ6SO6CYBP6RA3pmKQ-1
Received: by mail-qt1-f198.google.com with SMTP id
 d75a77b69052e-412ede7897aso138557341cf.1
 for <qemu-devel@nongnu.org>; Tue, 26 Sep 2023 22:03:41 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1695791021; x=1696395821;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=aWf/XtDJ6lWldjTJi7BhDN6gyWzLnfK6MWustL4P2TY=;
 b=bQiO22KD6zRkgYG8OwiMxdBm+nyLKSKr5kaFk+zUkTjKqe1kR46uAUMxM9ZpocmvkD
 1d99SgyY52CAf6kDc6JLxcpSBW/01Si7raKmMYmbU5qv/nPNaEfcqVCubTuk5Int5v1h
 NxaYgMWOvSlRm0WIaorKE+dWN2VD6Jm09GtwiL8DKwT22HriXasUG2kR8yr2XvBrdKrn
 APw72Ega3kD9bs4EgTRX05bUOoG4yUpp0ibenDgeieTCMYZUmAKr+g6wIwXYd+Dwdgu8
 60yVVdcl0raaOX+aU/BklNsqFUnyzv2y6iOBkwUHukzWslKMnZf7uYbRV0PetcW5K/MZ
 o6bA==
X-Gm-Message-State: AOJu0YzVkIEGw8gBlskGwSpcEFRHWAitwhP+gs7u2jqzVCeE3OCBhvMM
 irCE1kGFt0LE93esU5c7ZQMhBygKNIs19r3gIRXJE5Ozs7Izo2e4gcwjzYhsIY7h6VtfB6xeOlQ
 X+fi2ch6+Q8ag2A4=
X-Received: by 2002:a05:622a:1111:b0:417:b00f:9c8a with SMTP id
 e17-20020a05622a111100b00417b00f9c8amr1155560qty.27.1695791021256; 
 Tue, 26 Sep 2023 22:03:41 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEXLf9YVII023nAdvw9WEJEUKiR96PIsbnXFeV/DNxpsCXlPogrBar1QAA01VX8QqO/nXtecw==
X-Received: by 2002:a05:622a:1111:b0:417:b00f:9c8a with SMTP id
 e17-20020a05622a111100b00417b00f9c8amr1155544qty.27.1695791020934; 
 Tue, 26 Sep 2023 22:03:40 -0700 (PDT)
Received: from [192.168.0.5] (ip-109-43-178-22.web.vodafone.de.
 [109.43.178.22]) by smtp.gmail.com with ESMTPSA id
 l11-20020ac84ccb000000b004181441cb2dsm2542013qtv.34.2023.09.26.22.03.38
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 26 Sep 2023 22:03:40 -0700 (PDT)
Message-ID: <66963265-fdeb-9bb0-bc3e-a6cd57d53e57@redhat.com>
Date: Wed, 27 Sep 2023 07:03:36 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: [PATCH] optionrom: Remove build-id section
To: Fabiano Rosas <farosas@suse.de>, qemu-devel@nongnu.org
Cc: Paolo Bonzini <pbonzini@redhat.com>, =?UTF-8?Q?Alex_Benn=c3=a9e?=
 <alex.bennee@linaro.org>, Dario Faggioli <dfaggioli@suse.com>,
 Vasiliy Ulyanov <vulyanov@suse.de>
References: <20230926192502.15986-1-farosas@suse.de>
Content-Language: en-US
From: Thomas Huth <thuth@redhat.com>
In-Reply-To: <20230926192502.15986-1-farosas@suse.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=170.10.129.124; envelope-from=thuth@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -35
X-Spam_score: -3.6
X-Spam_bar: ---
X-Spam_report: (-3.6 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 NICE_REPLY_A=-1.473, RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001,
 RCVD_IN_MSPIKE_WL=0.001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

On 26/09/2023 21.25, Fabiano Rosas wrote:
> Our linker script for optionroms specifies only the placement of the
> .text section, leaving the linker free to place the remaining sections
> at arbitrary places in the file.
> 
> Since at least binutils 2.39, the .note.gnu.build-id section is now
> being placed at the start of the file, which causes label addresses to
> be shifted. For linuxboot_dma.bin that means that the PnP header
> (among others) will not be found when determining the type of ROM at
> optionrom_setup():
> 
> (0x1c is the label _pnph, where the magic "PnP" is)
> 
> $ xxd /usr/share/qemu/linuxboot_dma.bin | grep "PnP"
> 00000010: 0000 0000 0000 0000 0000 1c00 2450 6e50  ............$PnP
> 
> $ xxd pc-bios/optionrom/linuxboot_dma.bin | grep "PnP"
> 00000010: 0000 0000 0000 0000 0000 4c00 2450 6e50  ............$PnP
>                                     ^bad
> 
> Using a freshly built linuxboot_dma.bin ROM results in a broken boot:
> 
>    SeaBIOS (version rel-1.16.2-0-gea1b7a073390-prebuilt.qemu.org)
>    Booting from Hard Disk...
>    Boot failed: could not read the boot disk
> 
>    Booting from Floppy...
>    Boot failed: could not read the boot disk
> 
>    No bootable device.
> 
> We're not using the build-id section, so pass the --build-id=none
> option to the linker to remove it entirely.
> 
> Note: In theory, this same issue could happen with any other
> section. The ideal solution would be to have all unused sections
> discarded in the linker script. However that would be a larger change,
> specially for the pvh rom which uses the .bss and COMMON sections so
> I'm addressing only the immediate issue here.
> 
> Reported-by: Vasiliy Ulyanov <vulyanov@suse.de>
> Signed-off-by: Fabiano Rosas <farosas@suse.de>
> ---
>   pc-bios/optionrom/Makefile | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/pc-bios/optionrom/Makefile b/pc-bios/optionrom/Makefile
> index b1fff0ba6c..30d07026c7 100644
> --- a/pc-bios/optionrom/Makefile
> +++ b/pc-bios/optionrom/Makefile
> @@ -36,7 +36,7 @@ config-cc.mak: Makefile
>   	    $(call cc-option,-Wno-array-bounds)) 3> config-cc.mak
>   -include config-cc.mak
>   
> -override LDFLAGS = -nostdlib -Wl,-T,$(SRC_DIR)/flat.lds
> +override LDFLAGS = -nostdlib -Wl,--build-id=none,-T,$(SRC_DIR)/flat.lds
>   
>   pvh.img: pvh.o pvh_main.o

I remember that we had to do the same in other projects that use their own 
linker script (kvm-unit-tests?) ... so this looks fine to me.

Reviewed-by: Thomas Huth <thuth@redhat.com>


