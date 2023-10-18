Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 92FF07CD74F
	for <lists+qemu-devel@lfdr.de>; Wed, 18 Oct 2023 10:58:27 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qt2N2-0003HH-Fk; Wed, 18 Oct 2023 04:57:40 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <manos.pitsidianakis@linaro.org>)
 id 1qt2N1-0003Gt-3J
 for qemu-devel@nongnu.org; Wed, 18 Oct 2023 04:57:39 -0400
Received: from mail-lj1-x230.google.com ([2a00:1450:4864:20::230])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <manos.pitsidianakis@linaro.org>)
 id 1qt2Mz-0002Wv-BC
 for qemu-devel@nongnu.org; Wed, 18 Oct 2023 04:57:38 -0400
Received: by mail-lj1-x230.google.com with SMTP id
 38308e7fff4ca-2c51388ccebso54002831fa.3
 for <qemu-devel@nongnu.org>; Wed, 18 Oct 2023 01:57:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1697619455; x=1698224255; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:in-reply-to
 :references:user-agent:subject:cc:to:from:date:from:to:cc:subject
 :date:message-id:reply-to;
 bh=4y5u6asx5oA6Oo2XxkQHi8WQPGXPFnze72NaZnooRGk=;
 b=dVRs9Msn5sKFW75o/+bfbtC2JItxqDXmjakXlAOD4l2GeJGKxpHkBuZXyB+JbhyBIm
 wejfby06m4OTQ4X+Z1IXN599JzgEDdXxxwgdtcbKT2D1np4L4x3KxPAu7XgFEuYZo3p3
 4jcHb3d/hJOXmjWxcD/ddXJN18Ll1HSU4VS9FBoNYhojI28PpdHs0lwTyOj1NKifj5Aa
 buA0AuUvDuidRDVuC+pcv/9C1plCSWmx8U9B9oxwI0vsiZJLduVBAiBJCzZlRtFmiRKD
 q3N3wRvaAwlour2RKwxY40OlCRIAIdqBmzVEuFGJc660IySO5sJnqxaGE9hobvMSnmhO
 1OYQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1697619455; x=1698224255;
 h=content-transfer-encoding:mime-version:message-id:in-reply-to
 :references:user-agent:subject:cc:to:from:date:x-gm-message-state
 :from:to:cc:subject:date:message-id:reply-to;
 bh=4y5u6asx5oA6Oo2XxkQHi8WQPGXPFnze72NaZnooRGk=;
 b=UoJ/ix69PzYEng92aN8/dH3gIPmLUmwfUpl/G5gV/VY6WxPqCxFs40OR8+V0Tlck0V
 IAlGa+HvDHRoG5IB77Fy7yFWNum6KIvUfZ2BOU1FabXMT+9WtQKDYCClf2ndU5npzj1i
 qyAeg2mnWxAAVG2BEq5Ax/S08PDJ0LSiC8b4uycvCMXxatO6/V6ucb1pTrQkjgPbFtYE
 4/R+vENMZI2bjZ2n9aQRjZegl4jS49B1JN6vewFBYJFK6uqXEsV2lP5HmWKNRRNnefL0
 W+vnK3sWRzHMBtpJP659gaU7E7OtUCzHoPbCfwtHhtT1tXpPyoHK1iWyJDNasa2UvWwm
 j1tA==
X-Gm-Message-State: AOJu0Yzcr0YbcMMIgHncGWQFp9/npt0ZzgQv2aBc5SzctUY1WmwJBVLm
 8hQNm1dK659+9zI14+DPJIw3OQ==
X-Google-Smtp-Source: AGHT+IFAQI2SkjrxZMnho91LItDanKeemSx2NyAGKzrZyaECxFWm8Nl599XuKNX1F7aCyTjByspLiw==
X-Received: by 2002:a2e:a7ca:0:b0:2c5:3e:6bdb with SMTP id
 x10-20020a2ea7ca000000b002c5003e6bdbmr4184941ljp.32.1697619455160; 
 Wed, 18 Oct 2023 01:57:35 -0700 (PDT)
Received: from meli.delivery (adsl-165.37.6.1.tellas.gr. [37.6.1.165])
 by smtp.gmail.com with ESMTPSA id
 l22-20020a05600c1d1600b004042dbb8925sm1122586wms.38.2023.10.18.01.57.34
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 18 Oct 2023 01:57:34 -0700 (PDT)
Date: Wed, 18 Oct 2023 11:49:00 +0300
From: Manos Pitsidianakis <manos.pitsidianakis@linaro.org>
To: Gerd Hoffmann <kraxel@redhat.com>
Cc: Igor Skalkin <Igor.Skalkin@opensynergy.com>,
 Anton Yakovlev <Anton.Yakovlev@opensynergy.com>,
 Paolo Bonzini <pbonzini@redhat.com>, qemu-devel@nongnu.org,
 "Michael S. Tsirkin" <mst@redhat.com>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 "Daniel P. Berrang=?UTF-8?B?w6k=?= " <berrange@redhat.com>,
 Eduardo Habkost <eduardo@habkost.net>,
 Marc-Andr=?UTF-8?B?w6kg?=Lureau <marcandre.lureau@redhat.com>,
 Volker R=?UTF-8?B?w7w=?= melin <vr_qemu@t-online.de>,
 "K=?UTF-8?B?xZE=?= v=?UTF-8?B?w6E=?= g=?UTF-8?B?w7M=?= ,
 Zolt=?UTF-8?B?w6E=?= n" <DirtY.iCE.hu@gmail.com>,
 Alex Benn=?UTF-8?B?w6k=?= e <alex.bennee@linaro.org>,
 Philippe Mathieu-Daud=?UTF-8?B?w6kg?=<philmd@linaro.org>,
 Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>,
 Stefano Garzarella <sgarzare@redhat.com>
Subject: Re: [PATCH v11 00/11] Add VIRTIO sound card
User-Agent: meli 0.8.2
References: <cover.1696935992.git.manos.pitsidianakis@linaro.org>
In-Reply-To: <cover.1696935992.git.manos.pitsidianakis@linaro.org>
Message-ID: <2pvjw.psr1yjx1ztc1@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain; charset=utf-8; format=flowed
Received-SPF: pass client-ip=2a00:1450:4864:20::230;
 envelope-from=manos.pitsidianakis@linaro.org; helo=mail-lj1-x230.google.com
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

On Wed, 11 Oct 2023 17:34, Manos Pitsidianakis <manos.pitsidianakis@linaro.org> wrote:
>This patch series adds an audio device implementing the recent virtio 
>sound spec (1.2) and a corresponding PCI wrapper device.
>
>v11 can be found online at:
>
>https://gitlab.com/epilys/qemu/-/tree/virtio-snd-v11
>
>Ref 885b01fe272541fdab5583780d4c3a59bfd8e734

Hello Gerd, MAINTAINERS says you own the hw/audio subsystem, would you 
pull this in your tree if/when it is to be merged?

For context, the device was in hw/audio initially but in early list 
discussions we decided to move it with the rest of virtio devices.

At its current state it LGTM, if there's agreement that there are no 
issues we can merge this series.

All the best,

--
Manos

