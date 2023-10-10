Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id E04BC7C4145
	for <lists+qemu-devel@lfdr.de>; Tue, 10 Oct 2023 22:32:13 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qqJOH-00058G-61; Tue, 10 Oct 2023 16:31:41 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mark.cave-ayland@ilande.co.uk>)
 id 1qqJOE-00057s-Px; Tue, 10 Oct 2023 16:31:38 -0400
Received: from mail.ilande.co.uk ([2001:41c9:1:41f::167])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mark.cave-ayland@ilande.co.uk>)
 id 1qqJOD-0004Sp-5M; Tue, 10 Oct 2023 16:31:38 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=ilande.co.uk; s=20220518; h=Subject:Content-Transfer-Encoding:Content-Type:
 In-Reply-To:From:References:Cc:To:MIME-Version:Date:Message-ID:Sender:
 Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender
 :Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=98D/ebTkhokH9JP0njI2YMkaA5sXgzRwJPcSpeS6UXM=; b=XG7POHgfJKeepMV7ZeSEWfUWT9
 O7D/Zf9HUgcgZug7rOIIP0D6B+IHGt3/82Cj+b2NgjzxDvsrtnV4cHGcEZHLb/oub/49xDeKEg7MD
 ATaXrZGofaSbTmFSx7VKHp0x0kGZKpveEECnJvwTsxMqvXTjx9C8NbXYhn5pu8mQoqCmrb6PUT+WR
 TyU9jcXEHVZJQ6qPxb8GFIlQoHd5Yz+6/Crn4RaE9GKk7MMuwv/LHqIawMbBDk8huzjTeM8KXGBz2
 nLwXdaStVL6ZcSY+fo9jICUcz17GP4jYjb7WPsO6Z7MUbMirs22xxSEzh0AChpsQ1HafWeLWb/srD
 atzS6MnJtwj2k7MGe3qNgyVPukKd7D2/hnzYpCt9uZndYQu5echz/qsGNulmcuYzNR/iHXnhPhi6c
 CuOvhw7ERepYYCWRL8i/A2cGQutfyuIzhvbk0PPqmKmfFt+9OjXpmIBgIw1wGtU3oGcx2gD/RGLew
 w0XfeX1tBAHWmuHdAK6niNRJ1Pa8G8owR3vPUq4cxIHm1lguuQhNByQmeGi8Zhz9BruUQiATioIho
 Jd+gLi4fjP0CaC7Ka1GfdePmJfTa3DV4YcGCvLerEPGYhryuapNgMmyT4aEeFPwINdRZP5t8HLBCN
 ufn9UJoRQ1tnWGpL7qkzMjjH/mF9IBpzS8tlM23vg=;
Received: from [2a00:23c4:8baf:fd00:c6d1:cadd:26f:f4e2]
 by mail.ilande.co.uk with esmtpsa (TLS1.3:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.92) (envelope-from <mark.cave-ayland@ilande.co.uk>)
 id 1qqJO0-0001a3-LZ; Tue, 10 Oct 2023 21:31:28 +0100
Message-ID: <57112a6f-2624-4bd5-b301-cd28cb197771@ilande.co.uk>
Date: Tue, 10 Oct 2023 21:31:21 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
To: Glenn Miles <milesg@linux.vnet.ibm.com>, qemu-devel@nongnu.org
Cc: qemu-arm@nongnu.org, clg@kaod.org, clegoate@redhat.com,
 andrew@codeconstruct.com.au, joel@jms.id.au
References: <20231010195209.264757-1-milesg@linux.vnet.ibm.com>
Content-Language: en-US
From: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>
Autocrypt: addr=mark.cave-ayland@ilande.co.uk; keydata=
 xsBNBFQJuzwBCADAYvxrwUh1p/PvUlNFwKosVtVHHplgWi5p29t58QlOUkceZG0DBYSNqk93
 3JzBTbtd4JfFcSupo6MNNOrCzdCbCjZ64ik8ycaUOSzK2tKbeQLEXzXoaDL1Y7vuVO7nL9bG
 E5Ru3wkhCFc7SkoypIoAUqz8EtiB6T89/D9TDEyjdXUacc53R5gu8wEWiMg5MQQuGwzbQy9n
 PFI+mXC7AaEUqBVc2lBQVpAYXkN0EyqNNT12UfDLdxaxaFpUAE2pCa2LTyo5vn5hEW+i3VdN
 PkmjyPvL6DdY03fvC01PyY8zaw+UI94QqjlrDisHpUH40IUPpC/NB0LwzL2aQOMkzT2NABEB
 AAHNME1hcmsgQ2F2ZS1BeWxhbmQgPG1hcmsuY2F2ZS1heWxhbmRAaWxhbmRlLmNvLnVrPsLA
 eAQTAQIAIgUCVAm7PAIbAwYLCQgHAwIGFQgCCQoLBBYCAwECHgECF4AACgkQW8LFb64PMh9f
 NAgAuc3ObOEY8NbZko72AGrg2tWKdybcMVITxmcor4hb9155o/OWcA4IDbeATR6cfiDL/oxU
 mcmtXVgPqOwtW3NYAKr5g/FrZZ3uluQ2mtNYAyTFeALy8YF7N3yhs7LOcpbFP7tEbkSzoXNG
 z8iYMiYtKwttt40WaheWuRs0ZOLbs6yoczZBDhna3Nj0LA3GpeJKlaV03O4umjKJgACP1c/q
 T2Pkg+FCBHHFP454+waqojHp4OCBo6HyK+8I4wJRa9Z0EFqXIu8lTDYoggeX0Xd6bWeCFHK3
 DhD0/Xi/kegSW33unsp8oVcM4kcFxTkpBgj39dB4KwAUznhTJR0zUHf63M7ATQRUCbs8AQgA
 y7kyevA4bpetM/EjtuqQX4U05MBhEz/2SFkX6IaGtTG2NNw5wbcAfhOIuNNBYbw6ExuaJ3um
 2uLseHnudmvN4VSJ5Hfbd8rhqoMmmO71szgT/ZD9MEe2KHzBdmhmhxJdp+zQNivy215j6H27
 14mbC2dia7ktwP1rxPIX1OOfQwPuqlkmYPuVwZP19S4EYnCELOrnJ0m56tZLn5Zj+1jZX9Co
 YbNLMa28qsktYJ4oU4jtn6V79H+/zpERZAHmH40IRXdR3hA+Ye7iC/ZpWzT2VSDlPbGY9Yja
 Sp7w2347L5G+LLbAfaVoejHlfy/msPeehUcuKjAdBLoEhSPYzzdvEQARAQABwsBfBBgBAgAJ
 BQJUCbs8AhsMAAoJEFvCxW+uDzIfabYIAJXmBepHJpvCPiMNEQJNJ2ZSzSjhic84LTMWMbJ+
 opQgr5cb8SPQyyb508fc8b4uD8ejlF/cdbbBNktp3BXsHlO5BrmcABgxSP8HYYNsX0n9kERv
 NMToU0oiBuAaX7O/0K9+BW+3+PGMwiu5ml0cwDqljxfVN0dUBZnQ8kZpLsY+WDrIHmQWjtH+
 Ir6VauZs5Gp25XLrL6bh/SL8aK0BX6y79m5nhfKI1/6qtzHAjtMAjqy8ChPvOqVVVqmGUzFg
 KPsrrIoklWcYHXPyMLj9afispPVR8e0tMKvxzFBWzrWX1mzljbBlnV2n8BIwVXWNbgwpHSsj
 imgcU9TTGC5qd9g=
In-Reply-To: <20231010195209.264757-1-milesg@linux.vnet.ibm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-SA-Exim-Connect-IP: 2a00:23c4:8baf:fd00:c6d1:cadd:26f:f4e2
X-SA-Exim-Mail-From: mark.cave-ayland@ilande.co.uk
Subject: Re: [PATCH v3] misc/pca9552: Fix for pca9552 not getting reset
X-SA-Exim-Version: 4.2.1 (built Wed, 08 May 2019 21:11:16 +0000)
X-SA-Exim-Scanned: Yes (on mail.ilande.co.uk)
Received-SPF: pass client-ip=2001:41c9:1:41f::167;
 envelope-from=mark.cave-ayland@ilande.co.uk; helo=mail.ilande.co.uk
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, SPF_HELO_NONE=0.001,
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

On 10/10/2023 20:52, Glenn Miles wrote:

> Testing of the pca9552 device on the powernv platform
> showed that the reset method was not being called when
> an instance of the device was realized.  This was causing
> the INPUT0/INPUT1 POR values to be incorrect.
> 
> Fixed by overriding the parent pca955x_realize method with a
> new pca9552_realize method which first calls
> the parent pca955x_realize method followed by the
> pca9552_reset function.
> 
> Signed-off-by: Glenn Miles <milesg@linux.vnet.ibm.com>
> ---
>   hw/misc/pca9552.c | 7 +++++++
>   1 file changed, 7 insertions(+)
> 
> diff --git a/hw/misc/pca9552.c b/hw/misc/pca9552.c
> index fff19e369a..4e183cc554 100644
> --- a/hw/misc/pca9552.c
> +++ b/hw/misc/pca9552.c
> @@ -384,6 +384,12 @@ static void pca955x_realize(DeviceState *dev, Error **errp)
>       qdev_init_gpio_out(dev, s->gpio, k->pin_count);
>   }
>   
> +static void pca9552_realize(DeviceState *dev, Error **errp)
> +{
> +    pca955x_realize(dev, errp);
> +    pca9552_reset(dev);
> +}
> +
>   static Property pca955x_properties[] = {
>       DEFINE_PROP_STRING("description", PCA955xState, description),
>       DEFINE_PROP_END_OF_LIST(),
> @@ -417,6 +423,7 @@ static void pca9552_class_init(ObjectClass *oc, void *data)
>       PCA955xClass *pc = PCA955X_CLASS(oc);
>   
>       dc->reset = pca9552_reset;
> +    dc->realize = pca9552_realize;
>       dc->vmsd = &pca9552_vmstate;
>       pc->max_reg = PCA9552_LS3;
>       pc->pin_count = 16;

The reason that the reset function isn't being called here is because TYPE_I2C_SLAVE 
is derived from TYPE_DEVICE, and for various historical reasons the DeviceClass reset 
function is only called for devices that inherit from TYPE_SYS_BUS_DEVICE.

Probably the best way to make this work instead of mixing up the reset and realize 
parts of the object lifecycle is to convert pca9552_reset() to use the new Resettable 
interface for TYPE_PCA9552: take a look at commit d43e967f69 ("q800-glue.c: convert 
to Resettable interface") as an example, along with the documentation at 
https://www.qemu.org/docs/master/devel/reset.html.


ATB,

Mark.


