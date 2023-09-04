Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 4BCEE7915B2
	for <lists+qemu-devel@lfdr.de>; Mon,  4 Sep 2023 12:27:52 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qd6nl-0002D2-QE; Mon, 04 Sep 2023 06:27:25 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <manos.pitsidianakis@linaro.org>)
 id 1qd6mA-0001gI-L6
 for qemu-devel@nongnu.org; Mon, 04 Sep 2023 06:25:49 -0400
Received: from mail-wm1-x336.google.com ([2a00:1450:4864:20::336])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <manos.pitsidianakis@linaro.org>)
 id 1qd6ly-0004Eb-8z
 for qemu-devel@nongnu.org; Mon, 04 Sep 2023 06:25:39 -0400
Received: by mail-wm1-x336.google.com with SMTP id
 5b1f17b1804b1-4013454fa93so12798395e9.0
 for <qemu-devel@nongnu.org>; Mon, 04 Sep 2023 03:25:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1693823132; x=1694427932; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:in-reply-to
 :references:user-agent:subject:cc:to:from:date:from:to:cc:subject
 :date:message-id:reply-to;
 bh=Ml1xxTJVjPI8sqbbORt01R/FKzCE8EC/iqskPjiYzxQ=;
 b=I+OvzZ+nZn9Ai02I95+S/dQu1+5gT+o+gyOm/tbU6fKnwq2VFMo2x4u2hqFq4b8vvw
 DVY189bx6fgkYOJtnuNBQVA5U/NGlJcRNHBl0uyWUJbsl4/kNQWELOrLAql32bDP17g0
 VpkicN3A8F23Uikrg0BDhk3uwHyoOAqVKW1NQN633WwSw6K739nsAtkViwMBJxrenLvn
 /7vwjYdZ0QA6Nw1ZpU0vhd3jmNLz0RxL0JqL+Rzs1UO/RhQGDpz+eTHwmeBgFkBOqOzh
 juw4TOuinZKPm1Y9H/WzScAcYRFBLD9RVNwf5j5La6f+Vx4os7eH1uBbh4a2WB9n+UQm
 JlNA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1693823132; x=1694427932;
 h=content-transfer-encoding:mime-version:message-id:in-reply-to
 :references:user-agent:subject:cc:to:from:date:x-gm-message-state
 :from:to:cc:subject:date:message-id:reply-to;
 bh=Ml1xxTJVjPI8sqbbORt01R/FKzCE8EC/iqskPjiYzxQ=;
 b=AcYXWDWbn2rBybGU3oN1nEnMDQ5g3LZqK3tpUfHnVWlXgD1bVAvExUg4UV5zFdjVUv
 ISAcOvISvlInd4KAiV7pReaD3txODZESr4WjgZOmDtw9x9EkKG1EH/YkSwTpLpQ61Qwo
 9fuLqS8zhWFq7BM6Pxru3uTHcCgPpLsHtQBCfJfiVqurLHDUAfwnXgsmwKa/PdnTUoXL
 tXzFBDltPRkZwaD8dESzVzfj9k47fFAFn68VQ/MgZy+E38MfGW6LjRCQLoewd6fOEAzu
 1VyUCPaTGKLGMIi2gwSBRR3gjL9vaOJCppk95ELRXUM+mL6bzxvm0Mnq4mFF6q+egfPd
 Lrtw==
X-Gm-Message-State: AOJu0YxaZ6e/QEMZL7QHyCFJkAKF5lP86gh07A6r7opp8qdui7KcPAkx
 RmtW6NlhWlRrqC92Ji2Vj84hjw==
X-Google-Smtp-Source: AGHT+IHAgz3RgDkGWqMV4HtXmAE6SxnGHb0aaYK1QBfLWKbszWQ0ci52CGTSyJM8dGwkKxhFTQv2kg==
X-Received: by 2002:a7b:c4c7:0:b0:3fb:b890:128e with SMTP id
 g7-20020a7bc4c7000000b003fbb890128emr6379953wmk.33.1693823131744; 
 Mon, 04 Sep 2023 03:25:31 -0700 (PDT)
Received: from meli.delivery (adsl-170.109.242.226.tellas.gr.
 [109.242.226.170]) by smtp.gmail.com with ESMTPSA id
 t25-20020a7bc3d9000000b003fed4fa0c19sm16820403wmj.5.2023.09.04.03.25.31
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 04 Sep 2023 03:25:31 -0700 (PDT)
Date: Mon, 04 Sep 2023 13:24:46 +0300
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
Subject: Re: [PATCH v8 05/12] virtio-sound: handle VIRTIO_SND_R_PCM_INFO
 request
User-Agent: meli 0.8.0
References: <cover.1693252037.git.manos.pitsidianakis@linaro.org>
 <974d88412dd4ee18ae35efdbec657fa558c13fbf.1693252037.git.manos.pitsidianakis@linaro.org>
 <30dde76a-099c-1f03-93e3-0c962f15404d@linaro.org>
In-Reply-To: <30dde76a-099c-1f03-93e3-0c962f15404d@linaro.org>
Message-ID: <0giah.s27xvtlho1sb@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain; charset=utf-8; format=flowed
Received-SPF: pass client-ip=2a00:1450:4864:20::336;
 envelope-from=manos.pitsidianakis@linaro.org; helo=mail-wm1-x336.google.com
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

On Mon, 04 Sep 2023 13:13, Philippe Mathieu-Daudé <philmd@linaro.org> wrote:
>> +
>> +    pcm_info = g_new0(virtio_snd_pcm_info, req.count);
>> +    for (uint32_t i = req.start_id; i < req.start_id + req.count; i++) {
>
>Starting from req.start_id seems to increase this code complexity.

I see your point, will change it!

Manos

