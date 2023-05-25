Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id EC9C1710A2A
	for <lists+qemu-devel@lfdr.de>; Thu, 25 May 2023 12:33:29 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1q28HE-0002Sd-6T; Thu, 25 May 2023 06:33:00 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1q28HB-0002QX-O9
 for qemu-devel@nongnu.org; Thu, 25 May 2023 06:32:57 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1q28HA-0001yv-6e
 for qemu-devel@nongnu.org; Thu, 25 May 2023 06:32:57 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1685010775;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=FEVH6DkacaJgwWC+8//bto37GWwtp2WGKa4EBgcBcjo=;
 b=dTNfy8eDJ0NyGZQVZM1Nsy9P6Dy6Mx+eqxokO1+IfZslIaELdO6v2uEsletGDLNs3VDtrA
 HAUjdpHkN0R99ixUD5tmZqHenxsVsfqASrrCPBAmUI5fBB6tcZ2QxTdOiHXQP6sw2wpFZk
 ZROPlHG4oYk10TN+LuLWtVySpllPJ3Q=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-510-KoV3nyJkPgCevsw0kI-G7Q-1; Thu, 25 May 2023 06:32:53 -0400
X-MC-Unique: KoV3nyJkPgCevsw0kI-G7Q-1
Received: by mail-wm1-f72.google.com with SMTP id
 5b1f17b1804b1-3f60536450eso2661175e9.1
 for <qemu-devel@nongnu.org>; Thu, 25 May 2023 03:32:53 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1685010772; x=1687602772;
 h=content-transfer-encoding:in-reply-to:subject:from:references:cc:to
 :content-language:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=FEVH6DkacaJgwWC+8//bto37GWwtp2WGKa4EBgcBcjo=;
 b=h/PZrk6XoedwQ4j2sWEuvzqy4ccoi4KE+0yfohmI2uPKxkAAhsIPQSRzMFPl9k1mLF
 PIM1mKBp++j9qCa4gm0zY5N2+QMOknnwo0AqbqTtUse0El5iioHejDeOMpe2uom9GLeF
 IRqUsdGKrMe6ZKex6UCqZlsZO29QF6JmJTRvbR1TAXCI3BKkJMcyWmfSERLFflj4or4i
 GLfl3F24L/GG+gkmiwy+aCBPnsznryi6glZ0WrZHfrYqr7k/ognCHrU6R41onFn+qBT6
 cs0L/Qt0pDIxxOdCQTkhC1kzm+PdPpBNwC7FPEH9NbIvElJ/qBYD1B+s9ohfJdH/3FpW
 zPeg==
X-Gm-Message-State: AC+VfDzRcaubcUHN4gQs3Z1nLEAnNxsQpUUxYQejcWKtm6i3mEX1KLB/
 FGUvxfYabD4VcMiPogO905g4XyTXQIFJ+nm9Dgitnz+yoKiMWaRW5gdTsEJVd1ZvjN4Zi5vMI2F
 4PWOo8VSFYvdWQ98=
X-Received: by 2002:a05:600c:2157:b0:3f4:1cd8:3e99 with SMTP id
 v23-20020a05600c215700b003f41cd83e99mr2224080wml.28.1685010772556; 
 Thu, 25 May 2023 03:32:52 -0700 (PDT)
X-Google-Smtp-Source: ACHHUZ4VhvrHsXtrytp9NkDKAQJG7iEUOcylnr3zJWoxXNptADuY8PYF66UDkIrP8saLZ/KCQP9IiA==
X-Received: by 2002:a05:600c:2157:b0:3f4:1cd8:3e99 with SMTP id
 v23-20020a05600c215700b003f41cd83e99mr2224069wml.28.1685010772265; 
 Thu, 25 May 2023 03:32:52 -0700 (PDT)
Received: from [192.168.0.3] (ip-109-43-177-30.web.vodafone.de.
 [109.43.177.30]) by smtp.gmail.com with ESMTPSA id
 o11-20020a05600c378b00b003f195d540d9sm5320647wmr.14.2023.05.25.03.32.51
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 25 May 2023 03:32:51 -0700 (PDT)
Message-ID: <e6444d41-62ba-2381-3b26-78e75c2da56e@redhat.com>
Date: Thu, 25 May 2023 12:32:50 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.10.0
Content-Language: en-US
To: Peter Maydell <peter.maydell@linaro.org>
Cc: Marcin Juszkiewicz <marcin.juszkiewicz@linaro.org>,
 qemu-devel@nongnu.org, qemu-arm@nongnu.org,
 Leif Lindholm <quic_llindhol@quicinc.com>
References: <CAFEAcA9GamGybSzd8FKBtmZ2qMgjRFy6D=Vhu1y0dL8m9Sa80w@mail.gmail.com>
 <20230523155644.678524-1-marcin.juszkiewicz@linaro.org>
 <e682f6d5-acbe-7910-54ef-4d75c88a3d28@redhat.com>
 <4101dedc-91d7-1735-4655-81082931b79d@linaro.org>
 <49fa8502-70f9-cdc4-1058-9d4202400db6@redhat.com>
 <CAFEAcA8OUP9vnJwRxcT7AUWPD5ANhc17ETgePYPe2=-N_ZvCsw@mail.gmail.com>
From: Thomas Huth <thuth@redhat.com>
Subject: Re: [PATCH 1/2] docs: sbsa: correct graphics card name
In-Reply-To: <CAFEAcA8OUP9vnJwRxcT7AUWPD5ANhc17ETgePYPe2=-N_ZvCsw@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=170.10.133.124; envelope-from=thuth@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 NICE_REPLY_A=-0.107, RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001, T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

On 25/05/2023 12.05, Peter Maydell wrote:
> On Tue, 23 May 2023 at 19:41, Thomas Huth <thuth@redhat.com> wrote:
>>
>> On 23/05/2023 19.30, Marcin Juszkiewicz wrote:
>> ...
>>>> (is there a reason why it can't be disabled with "-vga none" or
>>>> "-nodefaults"?)
>>>
>>> That's something I need to check how it should be done.
>>
>> Other boards set mc->default_display in their ...class_init
>> function and then use pci_vga_init() (or vga_interface_type)
>> to instantiate their default display adapter ... however, that
>> does not seem to support the bochs adapter yet (see
>> vga_interfaces[] in softmmu/vl.c).
>>
>> Not sure whether it's worth the effort to extend vga_interfaces[]
>> in vl.c
> 
> Isn't that a legacy-command-line-option thing? I feel like
> the recommended way to select a different graphics card
> these days would be to use -device my-pci-vga-card ...

"-vga" is kind of legacy, indeed, but currently the sbsa-ref hard-codes the 
graphics card to be always available, so if you add a "-device 
something-vga-card" on the command line, you'd get two graphic cards on your 
machine, even if you use -nodefaults.

So there needs to be at least some logic dealing with vga_interface_type if 
we want to be able to select a different graphics card for this machine. 
Then why not go the full way and use pci_vga_init() here, too? ... that's 
certainly the least confusing way for the users.

  Thomas



