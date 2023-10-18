Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 1781F7CDDF0
	for <lists+qemu-devel@lfdr.de>; Wed, 18 Oct 2023 15:54:31 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qt6z2-0002p7-MB; Wed, 18 Oct 2023 09:53:12 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <manos.pitsidianakis@linaro.org>)
 id 1qt6yz-0002oA-Jm
 for qemu-devel@nongnu.org; Wed, 18 Oct 2023 09:53:09 -0400
Received: from mail-wm1-x332.google.com ([2a00:1450:4864:20::332])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <manos.pitsidianakis@linaro.org>)
 id 1qt6yp-0000EO-PO
 for qemu-devel@nongnu.org; Wed, 18 Oct 2023 09:53:02 -0400
Received: by mail-wm1-x332.google.com with SMTP id
 5b1f17b1804b1-40572aeb6d0so63782845e9.1
 for <qemu-devel@nongnu.org>; Wed, 18 Oct 2023 06:52:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1697637177; x=1698241977; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:in-reply-to
 :references:user-agent:subject:cc:to:from:date:from:to:cc:subject
 :date:message-id:reply-to;
 bh=Sacgj2KFP04ZAu6MVUAzpAsE/3CnVWF8wRRl9fzyJPA=;
 b=qmkPprriDYdtSyxV011dxwbdm/U1sY7vawAlSoXpg8zWLK4F7X0ZOt7f/7/a2/EpNk
 kgZXwXqR7bCWeRb7r4VXEOZx9fj7qmfqpqk009xejQRmDWfvRKer7iNJEgLAh5ElWX4H
 EWgSJxdR1GHAYqCnjsgtZjP2bbMaOJycC3+r1Uhl07L+xF6kFLC3QlYW8URc8rCrT7Gl
 Zlg/pm/0lSpBKXSJVJYIY97/q6hTBg8Lp6nwe+spmlc414AZyolE9oPISZv2pBm8/NVl
 YHjPhVwxDE9269j7kVmqFK6DJWtOL9mM70J6V3V6Z/NrN+/23XlBCMcQbXWjCtkRNI7Y
 7rIA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1697637177; x=1698241977;
 h=content-transfer-encoding:mime-version:message-id:in-reply-to
 :references:user-agent:subject:cc:to:from:date:x-gm-message-state
 :from:to:cc:subject:date:message-id:reply-to;
 bh=Sacgj2KFP04ZAu6MVUAzpAsE/3CnVWF8wRRl9fzyJPA=;
 b=sPtNyLOwXn+GoQFwT49qKP/xCTc3BopbFcDqNSCoG9/jChA1qkZCIi2oFruAWrHzyU
 SvSLrxiW+/hX/P0PLV+qhozJ+WBbQydLA/FaQ6rIrTCovJawKJNL4fXfbPvT1EcCsfut
 MM5pjzdZhp/Oe8hKb/EMvmPGJ9WRHgssAR97p/Og0dvvhy1PQ0b1csC4O4TzB5Z/+VCO
 0fOJgYe5dcifEVGGSXN+AH/aTZqbdKIhKCsZI6HhUHPdltzX6FJo5qS9EQTmhN0b86Nv
 RZfWjFuUL2AwiNY0ZlSQTPbksvS1dVxe8cXMa/KD7/mtnkvcZy0+pd2selIIjcKAe4LP
 sxJg==
X-Gm-Message-State: AOJu0Yx+6MslbyaVKueyi3M2rnN5EGF0qtDoemHFx/qeIWHa17M3Bs2j
 aJ9fYWEpGGEpdzb5tXnJD+OpWw==
X-Google-Smtp-Source: AGHT+IEv59KaetSAvF5irM11DlGYkFBz1/Tcj7ru9vIPNHcJQ7DEfZedPyoDI18U9q1xz1VFVe6eNw==
X-Received: by 2002:a05:600c:3c8a:b0:401:b2c7:349b with SMTP id
 bg10-20020a05600c3c8a00b00401b2c7349bmr3910338wmb.7.1697637177638; 
 Wed, 18 Oct 2023 06:52:57 -0700 (PDT)
Received: from meli.delivery (adsl-141.37.6.162.tellas.gr. [37.6.162.141])
 by smtp.gmail.com with ESMTPSA id
 g19-20020a05600c4ed300b003fefaf299b6sm1778988wmq.38.2023.10.18.06.52.56
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 18 Oct 2023 06:52:57 -0700 (PDT)
Date: Wed, 18 Oct 2023 16:44:00 +0300
From: Manos Pitsidianakis <manos.pitsidianakis@linaro.org>
To: "Michael S. Tsirkin" <mst@redhat.com>
Cc: Gerd Hoffmann <kraxel@redhat.com>,
 Igor Skalkin <Igor.Skalkin@opensynergy.com>,
 Anton Yakovlev <Anton.Yakovlev@opensynergy.com>,
 Paolo Bonzini <pbonzini@redhat.com>, qemu-devel@nongnu.org,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 "Daniel P. Berrang=?UTF-8?B?w6k=?= " <berrange@redhat.com>,
 Eduardo Habkost <eduardo@habkost.net>,
 Marc-Andr=?UTF-8?B?w6kg?=Lureau <marcandre.lureau@redhat.com>,
 Volker R=?UTF-8?B?w7wg?=melin <vr_qemu@t-online.de>,
 "K=?UTF-8?B?xZEg?=v=?UTF-8?B?w6Eg?=g=?UTF-8?B?w7Mg?=,
 Zolt=?UTF-8?B?w6Eg?=n" <DirtY.iCE.hu@gmail.com>,
 Alex Benn=?UTF-8?B?w6kg?=e <alex.bennee@linaro.org>,
 Philippe Mathieu-Daud=?UTF-8?B?w6kg?=<philmd@linaro.org>,
 Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>,
 Stefano Garzarella <sgarzare@redhat.com>
Subject: Re: [PATCH v11 00/11] Add VIRTIO sound card
User-Agent: meli 0.8.2
References: <cover.1696935992.git.manos.pitsidianakis@linaro.org>
 <2pvjw.psr1yjx1ztc1@linaro.org>
 <20231018050537-mutt-send-email-mst@kernel.org>
In-Reply-To: <20231018050537-mutt-send-email-mst@kernel.org>
Message-ID: <2q986.633fbwmm52y@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain; charset=utf-8; format=flowed
Received-SPF: pass client-ip=2a00:1450:4864:20::332;
 envelope-from=manos.pitsidianakis@linaro.org; helo=mail-wm1-x332.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
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

Hello Michael,

Thank you for your reply;

On Wed, 18 Oct 2023 12:08, "Michael S. Tsirkin" <mst@redhat.com> wrote:
>On Wed, Oct 18, 2023 at 11:49:00AM +0300, Manos Pitsidianakis wrote:
>> On Wed, 11 Oct 2023 17:34, Manos Pitsidianakis <manos.pitsidianakis@linaro.org> wrote:
>> > This patch series adds an audio device implementing the recent virtio
>> > sound spec (1.2) and a corresponding PCI wrapper device.
>> > 
>> > v11 can be found online at:
>> > 
>> > https://gitlab.com/epilys/qemu/-/tree/virtio-snd-v11
>> > 
>> > Ref 885b01fe272541fdab5583780d4c3a59bfd8e734
>> > 
>> Hello Gerd, MAINTAINERS says you own the hw/audio subsystem, would you pull
>> this in your tree if/when it is to be merged?
>> 
>> For context, the device was in hw/audio initially but in early list
>> discussions we decided to move it with the rest of virtio devices.
>
>Link to these discussions? virtio-gpu is under ./hw/display
>seems inconsistent.

I agree that it is inconsistent, but I do not know if there is a general 
consensus on this. I am fine with placing it anywhere that is deemed 
appropriate.

<87a5xkde0c.fsf@linaro.org>
https://lore.kernel.org/qemu-devel/87a5xkde0c.fsf@linaro.org/

>And you are asking Gerd to merge but
>your MAINTAINERS patch wouldn't even let people know
>he needs to be Cc'd on changes.

No, I didn't ask to merge this, I asked if Gerd would be the one merging 
it because I am not sure myself and wanted more information. What do you 
think should be the correct process?

--
Manos

