Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 5BC557D0FC9
	for <lists+qemu-devel@lfdr.de>; Fri, 20 Oct 2023 14:44:02 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qtopv-0000Ru-I3; Fri, 20 Oct 2023 08:42:45 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1qtopr-0000Pn-IZ
 for qemu-devel@nongnu.org; Fri, 20 Oct 2023 08:42:39 -0400
Received: from mail-ed1-x531.google.com ([2a00:1450:4864:20::531])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1qtopp-0006FX-Dl
 for qemu-devel@nongnu.org; Fri, 20 Oct 2023 08:42:39 -0400
Received: by mail-ed1-x531.google.com with SMTP id
 4fb4d7f45d1cf-53b32dca0bfso1739869a12.0
 for <qemu-devel@nongnu.org>; Fri, 20 Oct 2023 05:42:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1697805754; x=1698410554; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=uWxVZgE+Mx8LGqBqzleKmtV2pfMxP70GBwRM1li0jQU=;
 b=RcFjLilDzVDH4k6A/xB/6kzSMIwH9MuQYuNGHsGxV5QigYSzR2uMCqOJwQgGywLHWP
 ilJxdwZ5L17R4gyT+A+4D3eq4Ve63yJJ7VJdSHWEaxDt2+RYfwl+v4g2I9cfMbs2AwP1
 BGBPjlbME5BcJ3AvHDa1Z8hlsaIqxMyuROfLG4f+IRmRyxsGeO7UQ+bA0Kuv+JqQPCGE
 I0LgsATw27e0y718Pf30Jy4PuYJXun2yi0XM5zryEyOZcAoKTgF+7Kl7jH6cIHsKnFeo
 0FFZfGU2iSjUbAxWsOXUbd69wTGhrZQDNuqFJGgjFlgdQN3KtafjFrk+/hPGg912rKo/
 YpxA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1697805754; x=1698410554;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=uWxVZgE+Mx8LGqBqzleKmtV2pfMxP70GBwRM1li0jQU=;
 b=we26JnweELnihT1N7Jvyan+NUkcfq0d4djxHIhcbMRbIn+pWC8kIcwQZLjG+aEnLDD
 2aY2MOVPxSEYOmgtJmrLnw3oo/0PO51jp0cBrUojzykTIIhL6K6/T68O4guxBZUBdZ7/
 Mh7Umjw425i1R8bf2No0fTVhrDevcVB8HWI7QShHuVjO4aKGu1HB0XCnfsNkWVDTivT5
 u/OH1xThyscdjQagp/C1fy+vDVGxnfTV/CyMwhWiTC9KGmY+xn4/7rn2BOPYYHWoOaKu
 8lkUGbW+C74vPtjHcDUK7JXQNWZHYsnzk2z/vLxccfLSevXCbqUAaBYhxBJ/i7WR7Qg1
 Ij9A==
X-Gm-Message-State: AOJu0YzT1mNhRYfDiZD60ST51dmQ1i2E9iqslglPf+tJIidM+OKaHM0u
 fP6L/SE/JFbDRULgapTl/nntBQ==
X-Google-Smtp-Source: AGHT+IEF5YWnOYr+PGiXsrNe58SI6rcyLafdBx71c88M3qauX3sYmLSfZHg3GAgRPmIrOAU+8ZPWjA==
X-Received: by 2002:a50:a414:0:b0:52f:a763:aab4 with SMTP id
 u20-20020a50a414000000b0052fa763aab4mr1426587edb.5.1697805754411; 
 Fri, 20 Oct 2023 05:42:34 -0700 (PDT)
Received: from [192.168.69.115] (tbo33-h01-176-171-212-97.dsl.sta.abo.bbox.fr.
 [176.171.212.97]) by smtp.gmail.com with ESMTPSA id
 h28-20020a50cddc000000b0053e589016a7sm1408013edj.16.2023.10.20.05.42.33
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 20 Oct 2023 05:42:34 -0700 (PDT)
Message-ID: <74d96828-dae9-64fe-5947-ba83ce54206d@linaro.org>
Date: Fri, 20 Oct 2023 14:42:32 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.15.1
Subject: Re: [PATCH 1/1] stm32f2xx_usart: implement TX interrupts
Content-Language: en-US
To: Hans-Erik Floryd <hans-erik.floryd@rt-labs.com>
Cc: Alistair Francis <alistair@alistair23.me>,
 Peter Maydell <peter.maydell@linaro.org>,
 =?UTF-8?Q?Marc-Andr=c3=a9_Lureau?= <marcandre.lureau@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>,
 "open list:STM32F205" <qemu-arm@nongnu.org>,
 "open list:All patches CC here" <qemu-devel@nongnu.org>
References: <20231020111428.3260965-1-hans-erik.floryd@rt-labs.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@linaro.org>
In-Reply-To: <20231020111428.3260965-1-hans-erik.floryd@rt-labs.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2a00:1450:4864:20::531;
 envelope-from=philmd@linaro.org; helo=mail-ed1-x531.google.com
X-Spam_score_int: -53
X-Spam_score: -5.4
X-Spam_bar: -----
X-Spam_report: (-5.4 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, NICE_REPLY_A=-3.339,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

Hi Hans-Erik,

On 20/10/23 13:14, Hans-Erik Floryd wrote:
> Generate interrupt if either of the TXE, TC or RXNE bits are active
> and the corresponding interrupt enable bit is set.
> 
> Signed-off-by: Hans-Erik Floryd <hans-erik.floryd@rt-labs.com>
> ---
>   hw/char/stm32f2xx_usart.c         | 29 +++++++++++++++++------------
>   include/hw/char/stm32f2xx_usart.h | 10 ++++++----
>   2 files changed, 23 insertions(+), 16 deletions(-)
> 
> diff --git a/hw/char/stm32f2xx_usart.c b/hw/char/stm32f2xx_usart.c
> index fde67f4f03..2947c3a260 100644
> --- a/hw/char/stm32f2xx_usart.c
> +++ b/hw/char/stm32f2xx_usart.c
> @@ -53,6 +53,16 @@ static int stm32f2xx_usart_can_receive(void *opaque)
>       return 0;
>   }
>   
> +static void stm32f2xx_update(STM32F2XXUsartState *s)
> +{
> +    uint32_t mask = s->usart_sr & s->usart_cr1;
> +    if (mask & (USART_SR_TXE | USART_SR_TC | USART_SR_RXNE)) {
> +        qemu_set_irq(s->irq, 1);
> +    } else {
> +        qemu_set_irq(s->irq, 0);
> +    }
> +}
> +
>   static void stm32f2xx_usart_receive(void *opaque, const uint8_t *buf, int size)
>   {
>       STM32F2XXUsartState *s = opaque;
> @@ -66,9 +76,7 @@ static void stm32f2xx_usart_receive(void *opaque, const uint8_t *buf, int size)
>       s->usart_dr = *buf;
>       s->usart_sr |= USART_SR_RXNE;
>   
> -    if (s->usart_cr1 & USART_CR1_RXNEIE) {
> -        qemu_set_irq(s->irq, 1);
> -    }
> +    stm32f2xx_update(s);
>   
>       DB_PRINT("Receiving: %c\n", s->usart_dr);
>   }
> @@ -85,7 +93,7 @@ static void stm32f2xx_usart_reset(DeviceState *dev)
>       s->usart_cr3 = 0x00000000;
>       s->usart_gtpr = 0x00000000;
>   
> -    qemu_set_irq(s->irq, 0);
> +    stm32f2xx_update(s);
>   }
>   
>   static uint64_t stm32f2xx_usart_read(void *opaque, hwaddr addr,
> @@ -100,13 +108,14 @@ static uint64_t stm32f2xx_usart_read(void *opaque, hwaddr addr,
>       case USART_SR:
>           retvalue = s->usart_sr;
>           qemu_chr_fe_accept_input(&s->chr);
> +        stm32f2xx_update(s);
>           return retvalue;
>       case USART_DR:
>           DB_PRINT("Value: 0x%" PRIx32 ", %c\n", s->usart_dr, (char) s->usart_dr);
>           retvalue = s->usart_dr & 0x3FF;
>           s->usart_sr &= ~USART_SR_RXNE;
>           qemu_chr_fe_accept_input(&s->chr);
> -        qemu_set_irq(s->irq, 0);
> +        stm32f2xx_update(s);
>           return retvalue;
>       case USART_BRR:
>           return s->usart_brr;
> @@ -145,9 +154,7 @@ static void stm32f2xx_usart_write(void *opaque, hwaddr addr,
>           } else {
>               s->usart_sr &= value;
>           }
> -        if (!(s->usart_sr & USART_SR_RXNE)) {
> -            qemu_set_irq(s->irq, 0);
> -        }
> +        stm32f2xx_update(s);
>           return;
>       case USART_DR:
>           if (value < 0xF000) {
> @@ -161,6 +168,7 @@ static void stm32f2xx_usart_write(void *opaque, hwaddr addr,
>                  clear TC by writing 0 to the SR register, so set it again
>                  on each write. */
>               s->usart_sr |= USART_SR_TC;
> +            stm32f2xx_update(s);
>           }
>           return;
>       case USART_BRR:
> @@ -168,10 +176,7 @@ static void stm32f2xx_usart_write(void *opaque, hwaddr addr,
>           return;
>       case USART_CR1:
>           s->usart_cr1 = value;
> -            if (s->usart_cr1 & USART_CR1_RXNEIE &&
> -                s->usart_sr & USART_SR_RXNE) {
> -                qemu_set_irq(s->irq, 1);
> -            }
> +        stm32f2xx_update(s);
>           return;
>       case USART_CR2:
>           s->usart_cr2 = value;
> diff --git a/include/hw/char/stm32f2xx_usart.h b/include/hw/char/stm32f2xx_usart.h
> index 65bcc85470..fdfa7424a7 100644
> --- a/include/hw/char/stm32f2xx_usart.h
> +++ b/include/hw/char/stm32f2xx_usart.h
> @@ -48,10 +48,12 @@
>   #define USART_SR_TC   (1 << 6)
>   #define USART_SR_RXNE (1 << 5)
>   
> -#define USART_CR1_UE  (1 << 13)
> -#define USART_CR1_RXNEIE  (1 << 5)
> -#define USART_CR1_TE  (1 << 3)
> -#define USART_CR1_RE  (1 << 2)
> +#define USART_CR1_UE     (1 << 13)
> +#define USART_CR1_TXEIE  (1 << 7)
> +#define USART_CR1_TCEIE  (1 << 6)
> +#define USART_CR1_RXNEIE (1 << 5)
> +#define USART_CR1_TE     (1 << 3)
> +#define USART_CR1_RE     (1 << 2)
>   
>   #define TYPE_STM32F2XX_USART "stm32f2xx-usart"
>   OBJECT_DECLARE_SIMPLE_TYPE(STM32F2XXUsartState, STM32F2XX_USART)

To keep your changes trivial to review, I split your patch in 4:

1/ Extract stm32f2xx_update_irq()

-- >8 --
diff --git a/hw/char/stm32f2xx_usart.c b/hw/char/stm32f2xx_usart.c
index fde67f4f03..519d3461a3 100644
--- a/hw/char/stm32f2xx_usart.c
+++ b/hw/char/stm32f2xx_usart.c
@@ -53,6 +53,17 @@ static int stm32f2xx_usart_can_receive(void *opaque)
      return 0;
  }

+static void stm32f2xx_update_irq(STM32F2XXUsartState *s)
+{
+    uint32_t mask = s->usart_sr & s->usart_cr1;
+
+    if (mask & (USART_SR_TXE | USART_SR_TC | USART_SR_RXNE)) {
+        qemu_set_irq(s->irq, 1);
+    } else {
+        qemu_set_irq(s->irq, 0);
+    }
+}
+
  static void stm32f2xx_usart_receive(void *opaque, const uint8_t *buf, 
int size)
  {
      STM32F2XXUsartState *s = opaque;
@@ -66,9 +77,7 @@ static void stm32f2xx_usart_receive(void *opaque, 
const uint8_t *buf, int size)
      s->usart_dr = *buf;
      s->usart_sr |= USART_SR_RXNE;

-    if (s->usart_cr1 & USART_CR1_RXNEIE) {
-        qemu_set_irq(s->irq, 1);
-    }
+    stm32f2xx_update_irq(s);

      DB_PRINT("Receiving: %c\n", s->usart_dr);
  }
@@ -85,7 +94,7 @@ static void stm32f2xx_usart_reset(DeviceState *dev)
      s->usart_cr3 = 0x00000000;
      s->usart_gtpr = 0x00000000;

-    qemu_set_irq(s->irq, 0);
+    stm32f2xx_update_irq(s);
  }

  static uint64_t stm32f2xx_usart_read(void *opaque, hwaddr addr,
@@ -106,7 +115,7 @@ static uint64_t stm32f2xx_usart_read(void *opaque, 
hwaddr addr,
          retvalue = s->usart_dr & 0x3FF;
          s->usart_sr &= ~USART_SR_RXNE;
          qemu_chr_fe_accept_input(&s->chr);
-        qemu_set_irq(s->irq, 0);
+        stm32f2xx_update_irq(s);
          return retvalue;
      case USART_BRR:
          return s->usart_brr;
@@ -145,9 +154,7 @@ static void stm32f2xx_usart_write(void *opaque, 
hwaddr addr,
          } else {
              s->usart_sr &= value;
          }
-        if (!(s->usart_sr & USART_SR_RXNE)) {
-            qemu_set_irq(s->irq, 0);
-        }
+        stm32f2xx_update_irq(s);
          return;
      case USART_DR:
          if (value < 0xF000) {
@@ -168,10 +175,7 @@ static void stm32f2xx_usart_write(void *opaque, 
hwaddr addr,
          return;
      case USART_CR1:
          s->usart_cr1 = value;
-            if (s->usart_cr1 & USART_CR1_RXNEIE &&
-                s->usart_sr & USART_SR_RXNE) {
-                qemu_set_irq(s->irq, 1);
-            }
+        stm32f2xx_update_irq(s);
          return;
      case USART_CR2:
          s->usart_cr2 = value;
---

2/ Update IRQ when SR is read

-- >8 --
diff --git a/hw/char/stm32f2xx_usart.c b/hw/char/stm32f2xx_usart.c
index 519d3461a3..46e29089bc 100644
--- a/hw/char/stm32f2xx_usart.c
+++ b/hw/char/stm32f2xx_usart.c
@@ -109,6 +109,7 @@ static uint64_t stm32f2xx_usart_read(void *opaque, 
hwaddr addr,
      case USART_SR:
          retvalue = s->usart_sr;
          qemu_chr_fe_accept_input(&s->chr);
+        stm32f2xx_update_irq(s);
          return retvalue;
      case USART_DR:
          DB_PRINT("Value: 0x%" PRIx32 ", %c\n", s->usart_dr, (char) 
s->usart_dr);
---

Why is this required?

3/ Update IRQ when DR is written

-- >8 --
diff --git a/hw/char/stm32f2xx_usart.c b/hw/char/stm32f2xx_usart.c
index 46e29089bc..74f007591a 100644
--- a/hw/char/stm32f2xx_usart.c
+++ b/hw/char/stm32f2xx_usart.c
@@ -169,6 +169,7 @@ static void stm32f2xx_usart_write(void *opaque, 
hwaddr addr,
                 clear TC by writing 0 to the SR register, so set it again
                 on each write. */
              s->usart_sr |= USART_SR_TC;
+            stm32f2xx_update_irq(s);
          }
          return;
      case USART_BRR:
---

This change makes sense

4/ Add more CR1 bit definitions

-- >8 --
diff --git a/include/hw/char/stm32f2xx_usart.h 
b/include/hw/char/stm32f2xx_usart.h
index 65bcc85470..fdfa7424a7 100644
--- a/include/hw/char/stm32f2xx_usart.h
+++ b/include/hw/char/stm32f2xx_usart.h
@@ -49,6 +49,8 @@
  #define USART_SR_RXNE (1 << 5)

  #define USART_CR1_UE     (1 << 13)
+#define USART_CR1_TXEIE  (1 << 7)
+#define USART_CR1_TCEIE  (1 << 6)
  #define USART_CR1_RXNEIE (1 << 5)
  #define USART_CR1_TE     (1 << 3)
  #define USART_CR1_RE     (1 << 2)
---

These are not used, why add them?

Regards,

Phil.



