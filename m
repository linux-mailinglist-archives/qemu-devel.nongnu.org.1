Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 78E4E8FC5F7
	for <lists+qemu-devel@lfdr.de>; Wed,  5 Jun 2024 10:20:52 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sElsa-0006Sg-1C; Wed, 05 Jun 2024 04:20:20 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1sElsW-0006SJ-DV
 for qemu-devel@nongnu.org; Wed, 05 Jun 2024 04:20:16 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1sElsS-0002Yr-OD
 for qemu-devel@nongnu.org; Wed, 05 Jun 2024 04:20:16 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1717575611;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=EhakwUBG0/f11Jwhtcz8myaJBHPHtWdiPgA2KWZ4ma0=;
 b=Tgf7dUt9b3I9esZL/ErkzJaT9Ztlsg2ds2dG6hq8TGvDihNwsygoDJ3gr3ZQFdkSuXozJl
 Dpg2l8P+u52WFQ3xYrg/ds+9IuJGFpTQ7t1LHyW56U+Oh6jabkfF+6TaImQB5h5s7UfuJp
 p9RSUfpK7l+5aE/sSG+Wwe4aRPCvTqE=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-155-qerjN1dtOWqSmckmHq1jpA-1; Wed, 05 Jun 2024 04:20:09 -0400
X-MC-Unique: qerjN1dtOWqSmckmHq1jpA-1
Received: by mail-wr1-f69.google.com with SMTP id
 ffacd0b85a97d-35dcd39c6ebso378652f8f.1
 for <qemu-devel@nongnu.org>; Wed, 05 Jun 2024 01:20:09 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1717575608; x=1718180408;
 h=content-transfer-encoding:in-reply-to:autocrypt:from
 :content-language:references:cc:to:subject:user-agent:mime-version
 :date:message-id:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=EhakwUBG0/f11Jwhtcz8myaJBHPHtWdiPgA2KWZ4ma0=;
 b=uz8r26PYVCTKl1VM20tUmKQNBUJh3ivEmpZLAiTVgn3pOyDGEo8hiCqFxSBxHZ0PGQ
 jATeWqqdOg0dMET9gQYoSY3oclYTcTFKg4Vtt88pLFtaVl8JPRv1hNpwIvQ9b3G3SIxU
 kOJmh+0MKSCp2PnNuhSQGCXl7oPHpK1za1xut3ZSCILVbmpgZfqHDWciWtD7JUR71qTz
 /FO69YlGLaHSJrnAKN2SfTaNgLfe3HISt/I/d8b+jmHMjpvkVYh0d0CYpHkRuLX2f+Wk
 Y3eW9QhrcoT7RjtBxI8iL9wG2uWFpsn039dcE8qasZjIxiB6c7LChfOL+kjdZ25ABiV2
 6p5A==
X-Forwarded-Encrypted: i=1;
 AJvYcCX9MwMx5XR91t2LoMMZvleTQfewYRJ2kS5FPmSf02PkFtmcSb57MNkriP4tqSClqSlre53daRl/IZULHEFJbVk5EmmuS8o=
X-Gm-Message-State: AOJu0YxgMPwu9/KJC6YCJl0od9VcvCVICpshrqOnQNVBRYtDscgtO+Jh
 mV4l4ezuhsOEnm07YsS7lmzbQdor1fWTV/RNJPhNn61nSlot7/66HkPmjYngaSID9OLRpUlOAAU
 6fs9ll3v81BqC4Otasfe7DyJk8N1hFWPgvI6nisAYQhNou1rsRcHF
X-Received: by 2002:adf:e741:0:b0:34c:f87b:f9fb with SMTP id
 ffacd0b85a97d-35e7c57e466mr4306753f8f.25.1717575608315; 
 Wed, 05 Jun 2024 01:20:08 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGME/omS1uJHoXCCPtXLUGkvvzX5Qy1JYsWAj3vPYFpLP7umnxLgXvchQo9ExTX6mCJA9C33Q==
X-Received: by 2002:adf:e741:0:b0:34c:f87b:f9fb with SMTP id
 ffacd0b85a97d-35e7c57e466mr4306729f8f.25.1717575607847; 
 Wed, 05 Jun 2024 01:20:07 -0700 (PDT)
Received: from [10.33.192.191] (nat-pool-str-t.redhat.com. [149.14.88.106])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-42158134932sm11328135e9.30.2024.06.05.01.20.06
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 05 Jun 2024 01:20:07 -0700 (PDT)
Message-ID: <86ad1f68-a67e-4c30-9e65-cad8c607352d@redhat.com>
Date: Wed, 5 Jun 2024 10:20:06 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 4/5] s390x: Add boot device fallback infrastructure
To: jrossi@linux.ibm.com, qemu-devel@nongnu.org, qemu-s390x@nongnu.org
Cc: frankja@linux.ibm.com, nsg@linux.ibm.com
References: <20240529154311.734548-1-jrossi@linux.ibm.com>
 <20240529154311.734548-5-jrossi@linux.ibm.com>
Content-Language: en-US
From: Thomas Huth <thuth@redhat.com>
Autocrypt: addr=thuth@redhat.com; keydata=
 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
In-Reply-To: <20240529154311.734548-5-jrossi@linux.ibm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=170.10.129.124; envelope-from=thuth@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=unavailable autolearn_force=no
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

On 29/05/2024 17.43, jrossi@linux.ibm.com wrote:
> From: Jared Rossi <jrossi@linux.ibm.com>
> 
> Add a routine for loading the next IPLB if a device fails to boot.
> 
> This includes some minor changes to the List-Directed IPL routine so that the
> failing device may be retried using the legacy boot pointers before moving on to
> the next device.
> 
> Signed-off-by: Jared Rossi <jrossi@linux.ibm.com>
> ---
...
> diff --git a/pc-bios/s390-ccw/bootmap.c b/pc-bios/s390-ccw/bootmap.c
> index a2137449dc..69391557fa 100644
> --- a/pc-bios/s390-ccw/bootmap.c
> +++ b/pc-bios/s390-ccw/bootmap.c
> @@ -144,7 +144,10 @@ static block_number_t load_eckd_segments(block_number_t blk, bool ldipl,
>       bool more_data;
>   
>       memset(_bprs, FREE_SPACE_FILLER, sizeof(_bprs));
> -    read_block(blk, bprs, "BPRS read failed");
> +    if (!read_block_nonfatal(blk, bprs)) {
> +        IPL_assert(ldipl, "BPRS read failed");
> +        return -1;
> +    }
>   
>       do {
>           more_data = false;
> @@ -188,7 +191,10 @@ static block_number_t load_eckd_segments(block_number_t blk, bool ldipl,
>                    * I.e. the next ptr must point to the unused memory area
>                    */
>                   memset(_bprs, FREE_SPACE_FILLER, sizeof(_bprs));
> -                read_block(block_nr, bprs, "BPRS continuation read failed");
> +                if (!read_block_nonfatal(block_nr, bprs)) {
> +                    IPL_assert(ldipl, "BPRS continuation read failed");
> +                    break;
> +                }
>                   more_data = true;
>                   break;
>               }
> @@ -197,7 +203,10 @@ static block_number_t load_eckd_segments(block_number_t blk, bool ldipl,
>                * to memory (address).
>                */
>               rc = virtio_read_many(block_nr, (void *)(*address), count + 1);
> -            IPL_assert(rc == 0, "code chunk read failed");
> +            if (rc != 0) {
> +                IPL_assert(ldipl, "code chunk read failed");
> +                break;
> +            }
>   
>               *address += (count + 1) * virtio_get_block_size();
>           }
> @@ -295,13 +304,22 @@ static void run_eckd_boot_script(block_number_t bmt_block_nr,
>                  " maximum number of boot entries allowed");
>   
>       memset(sec, FREE_SPACE_FILLER, sizeof(sec));
> -    read_block(bmt_block_nr, sec, "Cannot read Boot Map Table");
> +    if (!read_block_nonfatal(bmt_block_nr, sec)) {
> +        IPL_assert(ldipl, "Cannot read Boot Map Table");
> +        return;
> +    }
>   
>       block_nr = gen_eckd_block_num(&bmt->entry[loadparm].xeckd, ldipl);
> -    IPL_assert(block_nr != -1, "Cannot find Boot Map Table Entry");
> +    if (block_nr == -1) {
> +        IPL_assert(ldipl, "Cannot find Boot Map Table Entry");
> +        return;
> +    }
>   
>       memset(sec, FREE_SPACE_FILLER, sizeof(sec));
> -    read_block(block_nr, sec, "Cannot read Boot Map Script");
> +    if (!read_block_nonfatal(block_nr, sec)) {
> +        IPL_assert(ldipl, "Cannot read Boot Map Script");
> +        return;
> +    }
>   
>       for (i = 0; bms->entry[i].type == BOOT_SCRIPT_LOAD ||
>                   bms->entry[i].type == BOOT_SCRIPT_SIGNATURE; i++) {
> @@ -319,13 +337,10 @@ static void run_eckd_boot_script(block_number_t bmt_block_nr,
>           } while (block_nr != -1);
>       }
>   
> -    if (ldipl && bms->entry[i].type != BOOT_SCRIPT_EXEC) {
> -        /* Abort LD-IPL and retry as CCW-IPL */
> +    if (bms->entry[i].type != BOOT_SCRIPT_EXEC) {
> +        IPL_assert(ldipl, "Unknown script entry type");
>           return;
>       }
> -
> -    IPL_assert(bms->entry[i].type == BOOT_SCRIPT_EXEC,
> -               "Unknown script entry type");
>       write_reset_psw(bms->entry[i].address.load_address); /* no return */
>       jump_to_IPL_code(0); /* no return */
>   }
> @@ -492,7 +507,7 @@ static void ipl_eckd(void)
>               /* LD-IPL does not use the S1B bock, just make it NULL */
>               run_eckd_boot_script(ldipl_bmt, NULL_BLOCK_NR);
>               /* Only return in error, retry as CCW-IPL */
> -            sclp_print("Retrying IPL ");
> +            sclp_print("LD-IPL failed, retrying device\n");
>               print_eckd_msg();
>           }
>           memset(sec, FREE_SPACE_FILLER, sizeof(sec));
> @@ -944,5 +959,5 @@ void zipl_load(void)
>           panic("\n! Unknown IPL device type !\n");
>       }
>   
> -    sclp_print("zIPL load failed.\n");
> +    panic("zIPL load failed.\n");

Why replacing the sclp_print() here? Wouldn't it be nicer to continue 
panicking on the calling site instead?

>   }
> diff --git a/pc-bios/s390-ccw/main.c b/pc-bios/s390-ccw/main.c
> index 3e51d698d7..248ed5a410 100644
> --- a/pc-bios/s390-ccw/main.c
> +++ b/pc-bios/s390-ccw/main.c
> @@ -53,6 +53,12 @@ unsigned int get_loadparm_index(void)
>       return atoui(loadparm_str);
>   }
>   
> +static void copy_qipl(void)
> +{
> +    QemuIplParameters *early_qipl = (QemuIplParameters *)QIPL_ADDRESS;
> +    memcpy(&qipl, early_qipl, sizeof(QemuIplParameters));
> +}

You could move this function as a static inline into iplb.h ...

...
> diff --git a/pc-bios/s390-ccw/netmain.c b/pc-bios/s390-ccw/netmain.c
> index 5cd619b2d6..65cee15fef 100644
> --- a/pc-bios/s390-ccw/netmain.c
> +++ b/pc-bios/s390-ccw/netmain.c
> @@ -36,6 +36,7 @@
>   #include "cio.h"
>   #include "virtio.h"
>   #include "s390-time.h"
> +#include "iplb.h"
>   
>   #define DEFAULT_BOOT_RETRIES 10
>   #define DEFAULT_TFTP_RETRIES 20
> @@ -51,6 +52,7 @@ void write_iplb_location(void) {}
>   #define STSI322_VMDB_UUID_OFFSET ((8 + 12) * 4)
>   
>   IplParameterBlock iplb __attribute__((aligned(PAGE_SIZE)));
> +QemuIplParameters qipl;
>   static char cfgbuf[2048];
>   
>   static SubChannelId net_schid = { .one = 1 };
> @@ -513,6 +515,8 @@ void main(void)
>   {
>       filename_ip_t fn_ip;
>       int rc, fnlen;
> +    QemuIplParameters *early_qipl = (QemuIplParameters *)QIPL_ADDRESS;
> +    memcpy(&qipl, early_qipl, sizeof(QemuIplParameters));

... then you could use copy_qipl() here, too.

  Thomas



