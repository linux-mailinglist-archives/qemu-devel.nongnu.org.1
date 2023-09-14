Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 14D2979FD96
	for <lists+qemu-devel@lfdr.de>; Thu, 14 Sep 2023 09:57:12 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qghDO-0002fY-Sp; Thu, 14 Sep 2023 03:56:42 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1qghDN-0002el-6o
 for qemu-devel@nongnu.org; Thu, 14 Sep 2023 03:56:41 -0400
Received: from mail-lj1-x22c.google.com ([2a00:1450:4864:20::22c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1qghDK-00036u-QN
 for qemu-devel@nongnu.org; Thu, 14 Sep 2023 03:56:40 -0400
Received: by mail-lj1-x22c.google.com with SMTP id
 38308e7fff4ca-2bfc68be09bso6330271fa.1
 for <qemu-devel@nongnu.org>; Thu, 14 Sep 2023 00:56:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1694678195; x=1695282995; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=JcjxzURANnfIPBM25wb1oU/7tUScROJiFGfjpjgI9U4=;
 b=Wn2h5+c68+hN7A5i4buWolvT1uc6D+vmZ1pd+9FIDrMvUcKAlZX2khAnkR1Lk738ft
 zhTlg01aZwyg3AQRCMt61vkxb3Kc0eVb2zRCmeFsmQ9+zRWZ4vTnvQjrVOVLJHDjHn3b
 WdrJij4tGTNvDvh9fLjwADt/1gTUYFzVYL5DlyNVsenmT1LyPhyTlQWwTVFMLbslDGRJ
 5yDHcBmuYWHfHCsRMUmpMSxDmxfvd7r/C6jPh9ESYLdbdZuPOqayN7MhReMt+Pqjytt+
 2sTcCWn5FEUi/2ofOCPIhrwyaHWOW/Rin2uwYuuNKnvNE5HLRE8dFRPNVf3aB1Py+g0G
 4Llg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1694678195; x=1695282995;
 h=content-transfer-encoding:in-reply-to:from:references:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=JcjxzURANnfIPBM25wb1oU/7tUScROJiFGfjpjgI9U4=;
 b=ZJkjtBdAYITrBopGaSso+en8yyAtFKDJId8r+SiKhdCa2AvJ4ivXcMcjZuAmkIT/pU
 vf+DVo6Ccz9jB2H3cQ449F0IVTcUwaZMFSvaOuhcaSp2EF7pWcQcNIgkl717FDxCt+uT
 34KeQS4rP0wiXWeyOzPtjallk/W6lAN98S5vhuGCd9i/swAa4DnW2LJYYH4p1+9hDGUV
 2uMGrrBJ9MzrXtmCA6Bnh2vsM1KQ7MFCl49TbUssBkxtAolsF3vR3zmjPrY/TsmFFDcS
 kBinEw1VvCroMx2lpPiMMno1C1dlpYJV+jW4QYOrOc3YC5J7qr1zhXKHmjaDfspL4agj
 /tdg==
X-Gm-Message-State: AOJu0YxwZTGPDWM6rHx+HcAqkQQInNqzdrZOXg11BpAjX9rZH24JUeuR
 c1lnqFXh37T/OLTm9RVO1cVqCupiJmLA2U+0y1o=
X-Google-Smtp-Source: AGHT+IHKwgmi38whPOri1EPlyOJNDy3aWY6CbxhVYXMd2lW2cr/S6etUFnRD52VIN+J70jE0BWqahQ==
X-Received: by 2002:a05:6512:1599:b0:501:b872:8c6c with SMTP id
 bp25-20020a056512159900b00501b8728c6cmr366924lfb.27.1694678195293; 
 Thu, 14 Sep 2023 00:56:35 -0700 (PDT)
Received: from [192.168.69.115] (sem44-h01-176-172-56-29.dsl.sta.abo.bbox.fr.
 [176.172.56.29]) by smtp.gmail.com with ESMTPSA id
 q2-20020ac24a62000000b00501c673e780sm172372lfp.84.2023.09.14.00.56.33
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 14 Sep 2023 00:56:34 -0700 (PDT)
Message-ID: <25d8059c-422a-3f2a-3f33-7a9848f4b3da@linaro.org>
Date: Thu, 14 Sep 2023 09:56:32 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.15.0
Subject: Re: [PATCH v2 08/20] asc: generate silence if FIFO empty but engine
 still running
Content-Language: en-US
To: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>, laurent@vivier.eu,
 qemu-devel@nongnu.org, =?UTF-8?Q?Volker_R=c3=bcmelin?=
 <vr_qemu@t-online.de>, Gerd Hoffmann <kraxel@redhat.com>,
 =?UTF-8?Q?Marc-Andr=c3=a9_Lureau?= <marcandre.lureau@redhat.com>
References: <20230909094827.33871-1-mark.cave-ayland@ilande.co.uk>
 <20230909094827.33871-9-mark.cave-ayland@ilande.co.uk>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@linaro.org>
In-Reply-To: <20230909094827.33871-9-mark.cave-ayland@ilande.co.uk>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2a00:1450:4864:20::22c;
 envelope-from=philmd@linaro.org; helo=mail-lj1-x22c.google.com
X-Spam_score_int: -35
X-Spam_score: -3.6
X-Spam_bar: ---
X-Spam_report: (-3.6 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, NICE_REPLY_A=-1.473,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
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


On 9/9/23 11:48, Mark Cave-Ayland wrote:
> MacOS (un)helpfully leaves the FIFO engine running even when all the samples have
> been written to the hardware, and expects the FIFO status flags and IRQ to be
> updated continuously.
> 
> There is an additional problem in that not all audio backends guarantee an
> all-zero output when there is no FIFO data available, in particular the Windows
> dsound backend which re-uses its internal circular buffer causing the last played
> sound to loop indefinitely.
> 
> Whilst this is effectively a bug in the Windows dsound backend, work around it
> for now using a simple heuristic: if the FIFO remains empty for half a cycle
> (~23ms) then continuously fill the generated buffer with empty silence.
> 
> Signed-off-by: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>
> ---
>   hw/audio/asc.c         | 19 +++++++++++++++++++
>   include/hw/audio/asc.h |  2 ++
>   2 files changed, 21 insertions(+)
> 
> diff --git a/hw/audio/asc.c b/hw/audio/asc.c
> index 336ace0cd6..b01b285512 100644
> --- a/hw/audio/asc.c
> +++ b/hw/audio/asc.c
> @@ -334,6 +334,21 @@ static void asc_out_cb(void *opaque, int free_b)
>       }
>   
>       if (!generated) {
> +        /* Workaround for audio underflow bug on Windows dsound backend */
> +        int64_t now = qemu_clock_get_ns(QEMU_CLOCK_VIRTUAL);
> +        int silent_samples = muldiv64(now - s->fifo_empty_ns,
> +                                      NANOSECONDS_PER_SECOND, ASC_FREQ);
> +
> +        if (silent_samples > ASC_FIFO_CYCLE_TIME / 2) {
> +            /*
> +             * No new FIFO data within half a cycle time (~23ms) so fill the
> +             * entire available buffer with silence. This prevents an issue
> +             * with the Windows dsound backend whereby the sound appears to
> +             * loop because the FIFO has run out of data, and the driver
> +             * reuses the stale content in its circular audio buffer.
> +             */
> +            AUD_write(s->voice, s->silentbuf, samples << s->shift);
> +        }
>           return;
>       }

What about having audio_callback_fn returning a boolean, and using
a flag in backends for that silence case? Roughtly:

-- >8 --
diff --git a/audio/audio.h b/audio/audio.h
index 01bdc567fb..4844771c92 100644
--- a/audio/audio.h
+++ b/audio/audio.h
@@ -30,7 +30,7 @@
  #include "hw/qdev-properties.h"
  #include "hw/qdev-properties-system.h"

-typedef void (*audio_callback_fn) (void *opaque, int avail);
+typedef bool (*audio_callback_fn) (void *opaque, int avail);

  #if HOST_BIG_ENDIAN
  #define AUDIO_HOST_ENDIANNESS 1
diff --git a/audio/audio.c b/audio/audio.c
index 90c7c49d11..5b6e69fbd6 100644
--- a/audio/audio.c
+++ b/audio/audio.c
@@ -1178,8 +1178,11 @@ static void audio_run_out (AudioState *s)
                  if (free > sw->resample_buf.pos) {
                      free = MIN(free, sw->resample_buf.size)
                             - sw->resample_buf.pos;
-                    sw->callback.fn(sw->callback.opaque,
-                                    free * sw->info.bytes_per_frame);
+                    if (!sw->callback.fn(sw->callback.opaque,
+                                         free * sw->info.bytes_per_frame)
+                            && unlikely(hw->silentbuf_required)) {
+                        /* write silence ... */
+                    }
                  }
              }
          }
---

