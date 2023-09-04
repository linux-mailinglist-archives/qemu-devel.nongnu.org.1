Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 4DADD79160D
	for <lists+qemu-devel@lfdr.de>; Mon,  4 Sep 2023 13:08:07 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qd7Qj-0003QA-DT; Mon, 04 Sep 2023 07:07:41 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <manos.pitsidianakis@linaro.org>)
 id 1qd7Qd-0003Lc-Eg
 for qemu-devel@nongnu.org; Mon, 04 Sep 2023 07:07:35 -0400
Received: from mail-wr1-x433.google.com ([2a00:1450:4864:20::433])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <manos.pitsidianakis@linaro.org>)
 id 1qd7Qa-00062m-Nb
 for qemu-devel@nongnu.org; Mon, 04 Sep 2023 07:07:35 -0400
Received: by mail-wr1-x433.google.com with SMTP id
 ffacd0b85a97d-31c5a2e8501so1027095f8f.0
 for <qemu-devel@nongnu.org>; Mon, 04 Sep 2023 04:07:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1693825651; x=1694430451; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:in-reply-to
 :references:user-agent:subject:cc:to:from:date:from:to:cc:subject
 :date:message-id:reply-to;
 bh=lQy2gn55curr1Vt0WpWPA8bQW4XCLVOjK1FLPN4NUN0=;
 b=Xh1W8y83u9RPvN4HcaZjPtkDK1uMfxhHzUn1BmWX1FurYYy3vvsDAHiXfTJ4xKpj9v
 CQbhVCItNLlpLR8wxy7goJNwwNvU+Cd+SQY7aFyN1GRB2jpS6xKGH3SnPN+wrbNlqyiG
 kpD2ooLqaGBXlA9U4nLLZZUi+2hnpSkQccjqPNuYM+ypKwYs40wAedjIEw6Er7sR0Cy6
 96Yljp5lVyYdVxzBIKQGAEW7Ns31Sn4bVoOUf/9DHX0PO6b5SyYXIR1ga8THgFncQU/h
 WlqfDVdrmSn8gZrOFGftnw77VyeELbD/N0Tvqh0+ef/oplTsZtLN2OiostMQ82qwM29p
 5wcQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1693825651; x=1694430451;
 h=content-transfer-encoding:mime-version:message-id:in-reply-to
 :references:user-agent:subject:cc:to:from:date:x-gm-message-state
 :from:to:cc:subject:date:message-id:reply-to;
 bh=lQy2gn55curr1Vt0WpWPA8bQW4XCLVOjK1FLPN4NUN0=;
 b=ZrmXmncqzBf4vf/6O81ZLa6QrXstS9AhjleIQgtcDmZ9sTyclnc53rla1mnW/XmPLD
 r/Yj+DfuWhqaDj6RGciZVVr8e48WlxavYpFI8MhLfYhrHqlj/SWVx3ON5FRlABEL2F2d
 5BWrDW4/cO340wLI6h1zyzW78iMIVMTNL7DYRTJnMteseasgOJmfhAF1p5iolQJJsxc/
 hYbuFIdEJJHMsS84zlO+Rj+9a2oCsP8lTHyKDwbIErQwtBIuz4WapUI+o+fPt8gj3Kk2
 PVb2BBY1LrVAmaXugj1/ggZY4gu2DlVp5uGVIojEA576/874nOzy6+o4wgwMCWO5ApBs
 XdQQ==
X-Gm-Message-State: AOJu0Ywok2nlm0M0AWlfDkzNSUnQOlo181SZWxY/h7OBJTQ2/vjcBfXs
 kznkoC3XoYrUQE0P+mMjiiA00g==
X-Google-Smtp-Source: AGHT+IHxWuZUjXFQnx53QLg67yG+sERt6WS1Z0u+Xloa9w4aUn1hgUwj7yEzrbqGDlB3SpAWeA8skQ==
X-Received: by 2002:a5d:424b:0:b0:31a:d551:c2c0 with SMTP id
 s11-20020a5d424b000000b0031ad551c2c0mr7463299wrr.57.1693825651169; 
 Mon, 04 Sep 2023 04:07:31 -0700 (PDT)
Received: from meli.delivery (adsl-170.109.242.226.tellas.gr.
 [109.242.226.170]) by smtp.gmail.com with ESMTPSA id
 k8-20020a5d6d48000000b0031434c08bb7sm14054353wri.105.2023.09.04.04.07.30
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 04 Sep 2023 04:07:30 -0700 (PDT)
Date: Mon, 04 Sep 2023 14:00:18 +0300
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
Subject: Re: [PATCH v8 03/12] virtio-sound: handle control messages and streams
User-Agent: meli 0.8.0
References: <cover.1693252037.git.manos.pitsidianakis@linaro.org>
 <e3e57dd125611eeb5e563eb7fab8eb89194ed50e.1693252037.git.manos.pitsidianakis@linaro.org>
 <198a502c-d7bb-5e83-08b4-f29222dd4d83@linaro.org>
In-Reply-To: <198a502c-d7bb-5e83-08b4-f29222dd4d83@linaro.org>
Message-ID: <0gk8g.5plunv7mgoh9@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain; charset=utf-8; format=flowed
Received-SPF: pass client-ip=2a00:1450:4864:20::433;
 envelope-from=manos.pitsidianakis@linaro.org; helo=mail-wr1-x433.google.com
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

On Mon, 04 Sep 2023 13:46, Philippe Mathieu-Daudé <philmd@linaro.org> wrote:
>> +    size_t sz = iov_to_buf(cmd->elem->out_sg,
>> +                           cmd->elem->out_num,
>> +                           0,
>> +                           &cmd->ctrl,
>> +                           sizeof(cmd->ctrl));
>> +    if (sz != sizeof(cmd->ctrl)) {
>> +        qemu_log_mask(LOG_GUEST_ERROR,
>> +                "%s: virtio-snd command size incorrect %zu vs \
>> +                %zu\n", __func__, sz, sizeof(cmd->ctrl));
>> +        return;
>> +    }
>> +
>> +    trace_virtio_snd_handle_code(cmd->ctrl.code,
>
>IIUC the spec, this structure is in little endian, is that right?
>So shouldn't swap various fields in this series?

Not sure about the answer to this. Need input from someone more 
knowledgeable in virtio.

