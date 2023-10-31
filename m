Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id A39D27DD8A3
	for <lists+qemu-devel@lfdr.de>; Tue, 31 Oct 2023 23:53:34 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qxxbg-0007ue-Jh; Tue, 31 Oct 2023 18:53:08 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1qxxbe-0007st-JN
 for qemu-devel@nongnu.org; Tue, 31 Oct 2023 18:53:06 -0400
Received: from mail-wm1-x32b.google.com ([2a00:1450:4864:20::32b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1qxxbc-0004kG-Ug
 for qemu-devel@nongnu.org; Tue, 31 Oct 2023 18:53:06 -0400
Received: by mail-wm1-x32b.google.com with SMTP id
 5b1f17b1804b1-4094301d505so19200685e9.2
 for <qemu-devel@nongnu.org>; Tue, 31 Oct 2023 15:53:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1698792783; x=1699397583; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:user-agent
 :in-reply-to:subject:cc:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=7ntdNAY6sYGc6qzsgxoTQAmxGDRs9RbJNFBSEgbFyZ0=;
 b=mn0mNzqW3QTvfYngYpa6roPziadazCWn1HaHT6BThLkG1vinMcIDNne6pYypGa9fne
 /lndO/3CRMlBrR/cbUekTD4tzTqGRn/W5GpgSJP3ttQZ0ZMnWK5RvzS8P7UYtRSeGorh
 RxlTwTIA5oU+3XmNh+VmIhMxle25vPudhAZ+1OyZooR4/32XevQ4ldSzWa4suUcAMibC
 ig2wZinnpAPJoVqSbb9r7ZF7CyFGOXufxSYIqw3U12aUDAf9tlqPARxOWUhgZGmRRFWh
 oYQIn/hb3nmTfl49CyY2L+Rwh6F3NuA0oBveF6fs8pAYVX9Ld3p8oAw7BRllU9RyJNB2
 ItzA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1698792783; x=1699397583;
 h=content-transfer-encoding:mime-version:message-id:date:user-agent
 :in-reply-to:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=7ntdNAY6sYGc6qzsgxoTQAmxGDRs9RbJNFBSEgbFyZ0=;
 b=Wei1FcJjrVMuQm35zgpTh4wRGRTWGkWco3XWaMHCNK2yNM7yydhiee2pllnr36udar
 qpPAZT/B1d1CsUj+oA0uzHjlzbeMR7ATxTElCGRpXARyvXbGlrmIeBAxFkw24EVYym0g
 BMIJFqRjypceyUybVy7Ijo1/h7UPbF6+X+VCZiQydLh57gDGfCBI+mVGOz3V/83cB02U
 I/9XelsyiEf4JtLk/6cSrxZzk00OXDiv68meoe1PGz7PWTAhl1e9j4hdq1VP3693b8Ta
 PfJdnYvpUKrIR+ReqYwWUl7pyf/Pj+aQaIwk0h1YUpNEgjI5nDcJWayBFs/A08UWtU/K
 c8DQ==
X-Gm-Message-State: AOJu0YwAjI2Dfk1J9c5L1+j8YecApGQhQgihGeyHU1TZ2+vsYGIx1Zq+
 xFKTw5pTXfA2iuBmAxydsip1Yg==
X-Google-Smtp-Source: AGHT+IENZz6EMQoXy26ttPEnyWfgGTfkak8Rc6XBKi0r4zEQoHGsI/thhibhBZuFSqOnOLiBWI3QvA==
X-Received: by 2002:adf:f14a:0:b0:32d:9f1b:3a1f with SMTP id
 y10-20020adff14a000000b0032d9f1b3a1fmr10547997wro.31.1698792782838; 
 Tue, 31 Oct 2023 15:53:02 -0700 (PDT)
Received: from draig.lan ([85.9.250.243]) by smtp.gmail.com with ESMTPSA id
 m7-20020a05600c4f4700b0040651505684sm2973851wmq.29.2023.10.31.15.53.02
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 31 Oct 2023 15:53:02 -0700 (PDT)
Received: from draig (localhost [IPv6:::1])
 by draig.lan (Postfix) with ESMTP id 04CA765724;
 Tue, 31 Oct 2023 22:53:02 +0000 (GMT)
From: =?utf-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>
To: Manos Pitsidianakis <manos.pitsidianakis@linaro.org>
Cc: qemu-devel@nongnu.org,   "Gerd Hoffmann" <kraxel@redhat.com>,   "Igor
 Skalkin" <Igor.Skalkin@opensynergy.com>,   "Anton Yakovlev"
 <Anton.Yakovlev@opensynergy.com>,   "Paolo Bonzini" <pbonzini@redhat.com>,
 "Michael S. Tsirkin" <mst@redhat.com>,   "Marcel Apfelbaum"
 <marcel.apfelbaum@gmail.com>,   =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?=
 <berrange@redhat.com>,   "Eduardo Habkost" <eduardo@habkost.net>,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 =?UTF-8?q?Volker=20R=C3=BCmelin?= <vr_qemu@t-online.de>,
 =?UTF-8?q?K=C5=91v=C3=A1g=C3=B3=2C=20Zolt=C3=A1n?=
 <DirtY.iCE.hu@gmail.com>,   =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?=
 <philmd@linaro.org>,   "Mark Cave-Ayland" <mark.cave-ayland@ilande.co.uk>,
 "Stefano Garzarella" <sgarzare@redhat.com>
Subject: Re: [PATCH v13 00/11] Add VIRTIO sound card
In-Reply-To: <cover.1698062525.git.manos.pitsidianakis@linaro.org> (Manos
 Pitsidianakis's message of "Mon, 23 Oct 2023 15:03:17 +0300")
User-Agent: mu4e 1.11.23; emacs 29.1
Date: Tue, 31 Oct 2023 22:53:01 +0000
Message-ID: <87il6mxv3m.fsf@draig.linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::32b;
 envelope-from=alex.bennee@linaro.org; helo=mail-wm1-x32b.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

Manos Pitsidianakis <manos.pitsidianakis@linaro.org> writes:

> This patch series adds an audio device implementing the recent virtio
> sound spec (1.2) and a corresponding PCI wrapper device.
>
> v13 can be found online at:
>
> https://gitlab.com/epilys/qemu/-/tree/virtio-snd-v13
>
> Ref e7fb941cf7636fdff40cbdcdcd660dec5f15ca3c
>
> Main differences with v12 patch series [^v12]:
>
> - Fixed device aliases (thanks Volker R=C3=BCmelin <vr_qemu@t-online.de>)

Gentle ping. Is this ready to be taken through Gerd's audio tree or
should it go another route? It would be nice to get it in for 8.2 and
the freeze is coming.

--=20
Alex Benn=C3=A9e
Virtualisation Tech Lead @ Linaro

