Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id F24C8785309
	for <lists+qemu-devel@lfdr.de>; Wed, 23 Aug 2023 10:49:30 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qYjY1-0001Ku-Kj; Wed, 23 Aug 2023 04:49:05 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <manos.pitsidianakis@linaro.org>)
 id 1qYjXz-0001Ke-Qn
 for qemu-devel@nongnu.org; Wed, 23 Aug 2023 04:49:03 -0400
Received: from mail-lj1-x22a.google.com ([2a00:1450:4864:20::22a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <manos.pitsidianakis@linaro.org>)
 id 1qYjXy-0006vN-Bi
 for qemu-devel@nongnu.org; Wed, 23 Aug 2023 04:49:03 -0400
Received: by mail-lj1-x22a.google.com with SMTP id
 38308e7fff4ca-2b9f0b7af65so82188631fa.1
 for <qemu-devel@nongnu.org>; Wed, 23 Aug 2023 01:49:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1692780540; x=1693385340;
 h=content-transfer-encoding:mime-version:message-id:in-reply-to
 :references:user-agent:subject:cc:to:from:date:from:to:cc:subject
 :date:message-id:reply-to;
 bh=LDsbp4ClE1P8vJ2wU9I0mjHqJBzoLoct160R14/b3yA=;
 b=BBXG0KxzGt5TRKWWDXAoaG4w4rifjno3OhvSx2C15VbdkwQhe29E2PxQUR/XOKV7HV
 F1xuOBbpj1cwyPhrtXVQylr+XapkGnqEKQS6K6yQzzcZfcz2kCIVSw82RGY2jAzuyd16
 xTEd770WhBXU6HTH3y5VoKcXoqPs9PSejsgx0inaiwTz1QlLipw0uYfnnmviA7eo5g7Y
 fL10fyiMINJagNFH1nROOD5rCnrcl105L1wqHX7jQNZ6yUdYIc3wXJApfBy78pNPcXjr
 RZQD7Olj1WIsPcsekJAjkkrtkeV2GHtG3KMzhzXg9sqq754VtZpawtPV5sf7TtEpM9cu
 mOww==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1692780540; x=1693385340;
 h=content-transfer-encoding:mime-version:message-id:in-reply-to
 :references:user-agent:subject:cc:to:from:date:x-gm-message-state
 :from:to:cc:subject:date:message-id:reply-to;
 bh=LDsbp4ClE1P8vJ2wU9I0mjHqJBzoLoct160R14/b3yA=;
 b=joCqhMMKNwcD7SRVHVVX9v0vgot8p92NfTHCg62ZXcGLKsfN/UEjkEMgxyrJLfMFcq
 A9+ILfjWI5A7C3/KjeWxzY9vlu3Kdtqdxa+Us77KDQqhBgzX7Y6LOLPZh5/hFQLv/QE9
 wQtYO5sj21EUrSpn9A8cmkVGIsoGPy+r3tTzPAIjiF+SRjKdyIRiGsaSi3n1TfbIoYvP
 d+aLEMr0uK2/ravLKsz8J5DVbBs14+GdoAsUoy0TgFDsiLcESpgW2qhaQ74L2d5EBJC0
 0gztz3B7PHhzmkNnvC+XQ5rEudgsnrhcYSK/j7KnvVZFJ89QCefWBTODGgTyKEbHRHD9
 uDDw==
X-Gm-Message-State: AOJu0YwCOxeIl/RXbD8rDosxX7iKGedCrmrsuWAUuRBIi24j+AZmpMvQ
 gMb2mB2SPePx7kyAEqPih+QKgA==
X-Google-Smtp-Source: AGHT+IH2l+6je8Oq2sLwfnf5w5lapOaNuqCjLLh9GVy1GppRYD24iSs/ud6tlUzxM8SZXxuBA35tVQ==
X-Received: by 2002:a2e:4952:0:b0:2b8:39e4:2e2c with SMTP id
 b18-20020a2e4952000000b002b839e42e2cmr8304381ljd.1.1692780540164; 
 Wed, 23 Aug 2023 01:49:00 -0700 (PDT)
Received: from meli.delivery (adsl-200.109.242.225.tellas.gr.
 [109.242.225.200]) by smtp.gmail.com with ESMTPSA id
 f23-20020a7bcd17000000b003fe4e1c5bcfsm453479wmj.0.2023.08.23.01.48.59
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 23 Aug 2023 01:48:59 -0700 (PDT)
Date: Wed, 23 Aug 2023 11:42:55 +0300
From: Manos Pitsidianakis <manos.pitsidianakis@linaro.org>
To: Philippe Mathieu-Daud=?UTF-8?B?w6kg?=<philmd@linaro.org>,
 qemu-devel@nongnu.org
Cc: Igor Skalkin <Igor.Skalkin@opensynergy.com>,
 Anton Yakovlev <Anton.Yakovlev@opensynergy.com>,
 Paolo Bonzini <pbonzini@redhat.com>, Gerd Hoffmann <kraxel@redhat.com>,
 "ichael S. Tsirkin" <mst@redhat.com>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 "Daniel P. Berrang=?UTF-8?B?w6k=?= " <berrange@redhat.com>,
 Eduardo Habkost <eduardo@habkost.net>,
 Marc-Andr=?UTF-8?B?w6kg?=Lureau <marcandre.lureau@redhat.com>,
 Volker R=?UTF-8?B?w7w=?= melin <vr_qemu@t-online.de>,
 "K=?UTF-8?B?xZE=?= v=?UTF-8?B?w6E=?= g=?UTF-8?B?w7M=?= ,
 Zolt=?UTF-8?B?w6E=?= n" <DirtY.iCE.hu@gmail.com>,
 Alex Benn=?UTF-8?B?w6k=?= e <alex.bennee@linaro.org>
Subject: Re: [PATCH v7 10/12] virtio-sound: implement audio output (TX)
User-Agent: meli 0.7.3
References: <cover.1692731646.git.manos.pitsidianakis@linaro.org>
 <fc270670926ec0ada64ef62172a2698bafa6f88e.1692731646.git.manos.pitsidianakis@linaro.org>
 <75a3c938-f8c1-36b7-2914-34fb7677dcb0@linaro.org>
In-Reply-To: <75a3c938-f8c1-36b7-2914-34fb7677dcb0@linaro.org>
Message-ID: <zu5tl.jerkcd652a2@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain; charset=utf-8; format=flowed
Received-SPF: pass client-ip=2a00:1450:4864:20::22a;
 envelope-from=manos.pitsidianakis@linaro.org; helo=mail-lj1-x22a.google.com
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

Hello Philippe,

On Wed, 23 Aug 2023 01:17, Philippe Mathieu-Daudé <philmd@linaro.org> wrote:
>> +    trace_virtio_snd_handle_xfer();
>
>Maybe ...
<- snip ->
>... it is more useful displaying the callback stream index here?
>
>            trace_virtio_snd_handle_xfer(hdr.stream_id);
>

Certainly, why not. This is an extremely noisy trace print by the way, I 
was not sure whether to keep it or not. Printing it inside the for-loop 
would potentially make it more noisy.

Would you say this warrants a new patch series version? Otherwise I will 
include it if other things come up as well.

Manos

