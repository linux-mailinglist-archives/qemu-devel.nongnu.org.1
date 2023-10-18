Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 730B07CE251
	for <lists+qemu-devel@lfdr.de>; Wed, 18 Oct 2023 18:09:35 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qt95T-0002t1-C3; Wed, 18 Oct 2023 12:07:59 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <manos.pitsidianakis@linaro.org>)
 id 1qt95R-0002is-KD
 for qemu-devel@nongnu.org; Wed, 18 Oct 2023 12:07:57 -0400
Received: from mail-wm1-x32b.google.com ([2a00:1450:4864:20::32b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <manos.pitsidianakis@linaro.org>)
 id 1qt95P-00016M-Ko
 for qemu-devel@nongnu.org; Wed, 18 Oct 2023 12:07:57 -0400
Received: by mail-wm1-x32b.google.com with SMTP id
 5b1f17b1804b1-40572aeb6d0so64914235e9.1
 for <qemu-devel@nongnu.org>; Wed, 18 Oct 2023 09:07:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1697645274; x=1698250074; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:in-reply-to
 :references:user-agent:subject:cc:to:from:date:from:to:cc:subject
 :date:message-id:reply-to;
 bh=mVvze6lA6WCtn5L7sIG5X+uKlbypxOpmWDg15VDSt0I=;
 b=PLxPpdD7oeSD1dI+uCj+dScZeI3Q8cLP7qkkfgVVLVJFyQ/nlRZIKNzQ4iq+JnCvW+
 BYewe01qpUhJmpnX8IqSb3mhgqQfANIOJjFJfEIt7QhW5jQZnzWCNFlf9WqFD4wSl2Wq
 udBouctrnQUGayvgkyiPoklcMolbrzKKIPPB+NhUQaebyO2wLO+CHbQO26C6iGfXyFG1
 q2YXMT8i6ZHnXTX1sH6Ig7zMtH7+xafyDLmTpuqn7+ETBA4H+DhUK8WJey54TtJ8Qwps
 09BCbwmFmHJraf7vMQw2gyBN5Ffp55fuDHkRJhrh3LyPURxyiBY5511ne2Rm9gWYRQel
 BFqw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1697645274; x=1698250074;
 h=content-transfer-encoding:mime-version:message-id:in-reply-to
 :references:user-agent:subject:cc:to:from:date:x-gm-message-state
 :from:to:cc:subject:date:message-id:reply-to;
 bh=mVvze6lA6WCtn5L7sIG5X+uKlbypxOpmWDg15VDSt0I=;
 b=AZDWK5s5YrIJ1bJC3yWTYR4PniXv4e0PAEryOG8QcQSgdvFRDUrXseSlpH16cwjFFo
 vXCE2iUSj2+yAFZyV8064sQBwOiXELWK6GEd8en8ld6JWYHBzly8DZjLdIkxC1AZN8XS
 xzlPqaRcD/7puR3teP2ICluswywtSPxXw0FSPmC2LayefN2bM4fhLCd5GE45Z4Y6EZ+U
 Gg3dYUJT8AP0c2YHRR3oLTOAuyztGLvOahHj76FBw2btTElJ4NR9PDJOCQL+jMAwbLLj
 R3xDTn5gcqMNxGbR94s/c02ZA+sUcBVE8UWSe9MDEtuCnXlFpyMjuVuzGp/gAlWdIFBv
 8TuQ==
X-Gm-Message-State: AOJu0YxGp/RqF5MyoOzotNvwgp35k2e/9xSPNNK3HkYkslh3KUqvRYI6
 l0EJj6cnmpPz0OXAUYytYCayXg==
X-Google-Smtp-Source: AGHT+IGXWtmCE5plold1WCa2aoTidoTnQvI+Nu0UzhbAzOUcrqHW8v4yo/e6jnKf6RsVbZUKeINR/w==
X-Received: by 2002:a7b:c44c:0:b0:406:8c7a:9520 with SMTP id
 l12-20020a7bc44c000000b004068c7a9520mr4158913wmi.36.1697645273660; 
 Wed, 18 Oct 2023 09:07:53 -0700 (PDT)
Received: from meli.delivery (adsl-165.37.6.1.tellas.gr. [37.6.1.165])
 by smtp.gmail.com with ESMTPSA id
 g11-20020a05600c310b00b003fe1fe56202sm2072908wmo.33.2023.10.18.09.07.53
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 18 Oct 2023 09:07:53 -0700 (PDT)
Date: Wed, 18 Oct 2023 19:07:03 +0300
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
 <2q986.633fbwmm52y@linaro.org>
 <20231018104939-mutt-send-email-mst@kernel.org>
In-Reply-To: <20231018104939-mutt-send-email-mst@kernel.org>
Message-ID: <2qfh3.reyfzjhivr0m@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain; charset=utf-8; format=flowed
Received-SPF: pass client-ip=2a00:1450:4864:20::32b;
 envelope-from=manos.pitsidianakis@linaro.org; helo=mail-wm1-x32b.google.com
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

On Wed, 18 Oct 2023 17:50, "Michael S. Tsirkin" <mst@redhat.com> wrote:
>> > > For context, the device was in hw/audio initially but in early 
>> > > list
>> > > discussions we decided to move it with the rest of virtio devices.
>> > 
>> > Link to these discussions? virtio-gpu is under ./hw/display
>> > seems inconsistent.
>> 
>> I agree that it is inconsistent, but I do not know if there is a general
>> consensus on this. I am fine with placing it anywhere that is deemed
>> appropriate.
>> 
>> <87a5xkde0c.fsf@linaro.org>
>> https://lore.kernel.org/qemu-devel/87a5xkde0c.fsf@linaro.org/
>> 
>> > And you are asking Gerd to merge but
>> > your MAINTAINERS patch wouldn't even let people know
>> > he needs to be Cc'd on changes.
>> 
>> No, I didn't ask to merge this, I asked if Gerd would be the one merging it
>> because I am not sure myself and wanted more information. What do you think
>> should be the correct process?
>
>I'd put it under audio and then you get an unambigous maintainer
>to go through.

Thank you! I will do just that.

