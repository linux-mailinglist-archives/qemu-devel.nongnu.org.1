Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id D3C797DD80D
	for <lists+qemu-devel@lfdr.de>; Tue, 31 Oct 2023 23:10:32 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qxwux-0001ve-8Y; Tue, 31 Oct 2023 18:08:59 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <tcminyard@gmail.com>)
 id 1qxwuv-0001ul-GR; Tue, 31 Oct 2023 18:08:57 -0400
Received: from mail-ot1-x333.google.com ([2607:f8b0:4864:20::333])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <tcminyard@gmail.com>)
 id 1qxwut-00067S-HE; Tue, 31 Oct 2023 18:08:57 -0400
Received: by mail-ot1-x333.google.com with SMTP id
 46e09a7af769-6d2de704f53so2954720a34.2; 
 Tue, 31 Oct 2023 15:08:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1698790133; x=1699394933; darn=nongnu.org;
 h=in-reply-to:content-disposition:mime-version:references:reply-to
 :message-id:subject:cc:to:from:date:sender:from:to:cc:subject:date
 :message-id:reply-to;
 bh=szRmH4mI1auJGFtVXIciKcFGknxwRbkeXSZ3Hrp7/rc=;
 b=lBU8S7VeMRAZPKTocSVf7RmlZmZxxd+CYxwEf5nX2RAzetS/x9DV80NbuSFSXXaiZk
 BV/Wmvc7mQ5Q5LCRjcIiCsTfB+XSjXXQ6G34ljKWpBTspOKFTtLInz5WkisuajTsjmyN
 pn9FoorLVGUWbkZsvQR3rOQrxJZg7XqtruqerFAooxQkeEXYq73FYFqEItAHgZh9KYk0
 D+gVyiNRPickDuTCjhnZO/wHwxEq9vAbuTHu2Mh5vSuLnDmuDGkoeNDZdyrqg61v5kiU
 HqZzPuNQytI37gV+1phoE2iYMOhPwsv6Ecgv1GsHHT7SFE3FruLyDMsgbkQWQoU70yy3
 JlOg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1698790133; x=1699394933;
 h=in-reply-to:content-disposition:mime-version:references:reply-to
 :message-id:subject:cc:to:from:date:sender:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=szRmH4mI1auJGFtVXIciKcFGknxwRbkeXSZ3Hrp7/rc=;
 b=FozEjTqzldvv70ivpcT8+P3hLA90Boe86dg0Q/u/iijqNT6Fk4KcZmMsetZCFNH9Vm
 ASj2sxAAPkq8cQxe8SmMIlFPQnqTl4VvqZNppI0xi/QLNWZvlln3mpVQV2G31Jix6SSB
 F6Wab14ENVHxiwdC+T8GR6Tv59w06ZeNlVGqrFKKte5t1pBNaSo5tn1oijfMv8P2TEd5
 whgmGNNv4GZn2jS0N6x7TDpXIpllDGrw9jazhiXpuHWavPEarpyZNzsDlqfFFkfoECrJ
 36vH3kuJqPaowEzr/63eMsgMjKO4dTYZli1rc/LmI8vkAItwqgfmhUFz6nDKH1P4NJEL
 RH6A==
X-Gm-Message-State: AOJu0Yz8Rx7ybR0mOCOj9ZPlQ+49z6DKdZKLfbLkxT6uSBVnYR1Jk0wW
 Easv8zS1Fb0Dts5J2223zg==
X-Google-Smtp-Source: AGHT+IGYKSdaE/Q0FZhjqoHsZfLzKxL8cRzTN7DPzqkGXFPGV6bRTbYoXqI/4+5+FKVajhNwYD67Mg==
X-Received: by 2002:a05:6830:348a:b0:6d3:a8b:b34 with SMTP id
 c10-20020a056830348a00b006d30a8b0b34mr4431288otu.5.1698790133260; 
 Tue, 31 Oct 2023 15:08:53 -0700 (PDT)
Received: from serve.minyard.net ([47.189.89.62])
 by smtp.gmail.com with ESMTPSA id
 l18-20020a056830269200b006b871010cb1sm31663otu.46.2023.10.31.15.08.52
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 31 Oct 2023 15:08:52 -0700 (PDT)
Received: from mail.minyard.net (unknown
 [IPv6:2001:470:b8f6:1b:bec2:80c4:26f2:c650])
 by serve.minyard.net (Postfix) with ESMTPSA id 46569180053;
 Tue, 31 Oct 2023 22:08:52 +0000 (UTC)
Date: Tue, 31 Oct 2023 17:08:51 -0500
From: Corey Minyard <minyard@acm.org>
To: Bernhard Beschow <shentey@gmail.com>
Cc: qemu-devel@nongnu.org, Peter Maydell <peter.maydell@linaro.org>,
 qemu-trivial@nongnu.org, Stefan Hajnoczi <stefanha@redhat.com>,
 Jean-Christophe Dubois <jcd@tribudubois.net>, qemu-arm@nongnu.org,
 Andrey Smirnov <andrew.smirnov@gmail.com>,
 Peter Xu <peterx@redhat.com>, David Hildenbrand <david@redhat.com>,
 "Michael S. Tsirkin" <mst@redhat.com>, Mads Ynddal <mads@ynddal.dk>,
 Paolo Bonzini <pbonzini@redhat.com>,
 Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: Re: [PATCH 5/6] hw/i2c/pm_smbus: Convert DPRINTF to trace events
Message-ID: <ZUF681AIr/RWaUAq@mail.minyard.net>
References: <20231028122415.14869-1-shentey@gmail.com>
 <20231028122415.14869-6-shentey@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231028122415.14869-6-shentey@gmail.com>
Received-SPF: pass client-ip=2607:f8b0:4864:20::333;
 envelope-from=tcminyard@gmail.com; helo=mail-ot1-x333.google.com
X-Spam_score_int: -14
X-Spam_score: -1.5
X-Spam_bar: -
X-Spam_report: (-1.5 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FORGED_FROMDOMAIN=0.249,
 FREEMAIL_FROM=0.001, HEADER_FROM_DIFFERENT_DOMAINS=0.25,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=no autolearn_force=no
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
Reply-To: minyard@acm.org
Errors-To: qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org
Sender: qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org

On Sat, Oct 28, 2023 at 02:24:14PM +0200, Bernhard Beschow wrote:
> Let the trace messages slightly deviate from the function names
> ("smb" -> "smbus") being traced in order to avoid conflights with the SMB
> protocol.
> 
> Signed-off-by: Bernhard Beschow <shentey@gmail.com>

Looks good to me.

Acked-by: Corey Minyard <cminyard@mvista.com>

> ---
>  hw/i2c/pm_smbus.c   | 18 ++++--------------
>  hw/i2c/trace-events |  6 ++++++
>  2 files changed, 10 insertions(+), 14 deletions(-)
> 
> diff --git a/hw/i2c/pm_smbus.c b/hw/i2c/pm_smbus.c
> index 4e1b8a5182..78e7c229a8 100644
> --- a/hw/i2c/pm_smbus.c
> +++ b/hw/i2c/pm_smbus.c
> @@ -23,6 +23,7 @@
>  #include "hw/i2c/pm_smbus.h"
>  #include "hw/i2c/smbus_master.h"
>  #include "migration/vmstate.h"
> +#include "trace.h"
>  
>  #define SMBHSTSTS       0x00
>  #define SMBHSTCNT       0x02
> @@ -64,15 +65,6 @@
>  #define AUX_BLK       (1 << 1)
>  #define AUX_MASK      0x3
>  
> -/*#define DEBUG*/
> -
> -#ifdef DEBUG
> -# define SMBUS_DPRINTF(format, ...)     printf(format, ## __VA_ARGS__)
> -#else
> -# define SMBUS_DPRINTF(format, ...)     do { } while (0)
> -#endif
> -
> -
>  static void smb_transaction(PMSMBus *s)
>  {
>      uint8_t prot = (s->smb_ctl >> 2) & 0x07;
> @@ -82,7 +74,7 @@ static void smb_transaction(PMSMBus *s)
>      I2CBus *bus = s->smbus;
>      int ret;
>  
> -    SMBUS_DPRINTF("SMBus trans addr=0x%02x prot=0x%02x\n", addr, prot);
> +    trace_smbus_transaction(addr, prot);
>      /* Transaction isn't exec if STS_DEV_ERR bit set */
>      if ((s->smb_stat & STS_DEV_ERR) != 0)  {
>          goto error;
> @@ -258,8 +250,7 @@ static void smb_ioport_writeb(void *opaque, hwaddr addr, uint64_t val,
>      PMSMBus *s = opaque;
>      uint8_t clear_byte_done;
>  
> -    SMBUS_DPRINTF("SMB writeb port=0x%04" HWADDR_PRIx
> -                  " val=0x%02" PRIx64 "\n", addr, val);
> +    trace_smbus_ioport_writeb(addr, val);
>      switch(addr) {
>      case SMBHSTSTS:
>          clear_byte_done = s->smb_stat & val & STS_BYTE_DONE;
> @@ -429,8 +420,7 @@ static uint64_t smb_ioport_readb(void *opaque, hwaddr addr, unsigned width)
>          val = 0;
>          break;
>      }
> -    SMBUS_DPRINTF("SMB readb port=0x%04" HWADDR_PRIx " val=0x%02x\n",
> -                  addr, val);
> +    trace_smbus_ioport_readb(addr, val);
>  
>      if (s->set_irq) {
>          s->set_irq(s, smb_irq_value(s));
> diff --git a/hw/i2c/trace-events b/hw/i2c/trace-events
> index d7b1e25858..6900e06eda 100644
> --- a/hw/i2c/trace-events
> +++ b/hw/i2c/trace-events
> @@ -15,6 +15,12 @@ i2c_send_async(uint8_t address, uint8_t data) "send_async(addr:0x%02x) data:0x%0
>  i2c_recv(uint8_t address, uint8_t data) "recv(addr:0x%02x) data:0x%02x"
>  i2c_ack(void) ""
>  
> +# pm_smbus.c
> +
> +smbus_ioport_readb(uint16_t addr, uint8_t data) "[0x%04" PRIx16 "] -> val=0x%02x"
> +smbus_ioport_writeb(uint16_t addr, uint8_t data) "[0x%04" PRIx16 "] <- val=0x%02x"
> +smbus_transaction(uint8_t addr, uint8_t prot) "addr=0x%02x prot=0x%02x"
> +
>  # allwinner_i2c.c
>  
>  allwinner_i2c_read(const char* reg_name, uint64_t offset, uint64_t value) "read %s [0x%" PRIx64 "]: -> 0x%" PRIx64
> -- 
> 2.42.0
> 
> 

