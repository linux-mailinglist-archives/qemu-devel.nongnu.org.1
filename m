Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 16AD37D2D3A
	for <lists+qemu-devel@lfdr.de>; Mon, 23 Oct 2023 10:52:49 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1quqek-0004Wi-4N; Mon, 23 Oct 2023 04:51:26 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <manos.pitsidianakis@linaro.org>)
 id 1quqef-0004WG-Dl
 for qemu-devel@nongnu.org; Mon, 23 Oct 2023 04:51:21 -0400
Received: from mail-lf1-x136.google.com ([2a00:1450:4864:20::136])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <manos.pitsidianakis@linaro.org>)
 id 1quqed-0005Sa-E5
 for qemu-devel@nongnu.org; Mon, 23 Oct 2023 04:51:21 -0400
Received: by mail-lf1-x136.google.com with SMTP id
 2adb3069b0e04-507bd64814fso4360919e87.1
 for <qemu-devel@nongnu.org>; Mon, 23 Oct 2023 01:51:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1698051076; x=1698655876; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:in-reply-to
 :references:user-agent:subject:cc:to:from:date:from:to:cc:subject
 :date:message-id:reply-to;
 bh=GbZEZQFj9MryLDQbV2LWHW31QAGlSw5x6vf5u+LKc0w=;
 b=PHwEw236F671x+OF7f5vtyuKBCKEfuTaXsyfJtVSMEnnmqURIV4tclEtB/qBHQWlaE
 8G+4FMVhfMeDS7POPFQBUJ8dtlV8D52WI6xn4mYpQ/2Lf4QdkrOo9x9jRndCLHY2DpAc
 bP29FOFy0WhumwWifpDVyE884rNYPXQZjRW5Sjl2GdzTw27O2dOWP3/kf/L47QtdnGXX
 e7DLUmqG7pYLuJodd4WBrtwAQ9Vq2VhjMg9eqeGmTLlIHBy7E01IpC/TSh9swIvDK6BM
 lrLUdKay7JIWFB3W9xSFyZ8cXxw9wzt42BaWCTH0fTrxoANgbu6TrB+0PZB77BzrvtVw
 mvlA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1698051076; x=1698655876;
 h=content-transfer-encoding:mime-version:message-id:in-reply-to
 :references:user-agent:subject:cc:to:from:date:x-gm-message-state
 :from:to:cc:subject:date:message-id:reply-to;
 bh=GbZEZQFj9MryLDQbV2LWHW31QAGlSw5x6vf5u+LKc0w=;
 b=JcDX9GAelYqgf6sqLM1xQlDuWM/CPfk1zVPSiCvF+e9kKhYZnu4hopqdb+yo8/b/op
 WcQg5WHnMqy4xLiPXPUKkrIpr0l49ZBlXSNETAp75Sny674jMZTUC3X8DC5jQaKPr6pV
 K6qtcNVetSjDUyZTyaiKr1HEmPf2a1jCjgwYQqyNeZgRaRqd8HFVY4Eh3RDEqOR5eeJ+
 0XsuoaTQk5tF4bl4xh0C7PSYQiSZwHALcd6+jZa3tMkzuLYT9Ho/zLMkH5bo/8sPjkbb
 ntlo1GLB05rTdgGB+RZ9oTJhL6vq/XTmurmnc8+Tpl4aBZo/HXCMuP1ImlFjgNAQpW9+
 EmRQ==
X-Gm-Message-State: AOJu0YzlhxmTnUnFLYl/ULCEwLJwUya/o0phhxDA94ma9VeggpQN/fbd
 2dfuYz4l2cTKyHPCkdUoYzn+Hg==
X-Google-Smtp-Source: AGHT+IFF2cRTv1ZkAJ3PJMDSwB8EA5Rv1go6SLmAHynEhiLAEIproSC+BfXOqhFSFJ2BkkvjlDgRPA==
X-Received: by 2002:a05:6512:4019:b0:507:a620:6b96 with SMTP id
 br25-20020a056512401900b00507a6206b96mr7236838lfb.57.1698051076122; 
 Mon, 23 Oct 2023 01:51:16 -0700 (PDT)
Received: from meli.delivery (adsl-165.37.6.1.tellas.gr. [37.6.1.165])
 by smtp.gmail.com with ESMTPSA id
 l6-20020a5d4106000000b0032d9382e6e0sm7291562wrp.45.2023.10.23.01.51.14
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 23 Oct 2023 01:51:15 -0700 (PDT)
Date: Mon, 23 Oct 2023 11:48:20 +0300
From: Manos Pitsidianakis <manos.pitsidianakis@linaro.org>
To: Volker R=?UTF-8?B?w7w=?= melin <vr_qemu@t-online.de>,
 Gerd Hoffmann <kraxel@redhat.com>
Cc: Igor Skalkin <Igor.Skalkin@opensynergy.com>,
 Anton Yakovlev <Anton.Yakovlev@opensynergy.com>,
 Paolo Bonzini <pbonzini@redhat.com>, "Michael S. Tsirkin" <mst@redhat.com>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 "Daniel P. Berrang=?UTF-8?B?w6k=?= " <berrange@redhat.com>,
 Eduardo Habkost <eduardo@habkost.net>,
 Marc-Andr =?UTF-8?B?w6kg?=Lureau <marcandre.lureau@redhat.com>,
 "K=?UTF-8?B?xZEg?=v=?UTF-8?B?w6Eg?=g=?UTF-8?B?w7Mg?=,
 Zolt=?UTF-8?B?w6Eg?=n" <DirtY.iCE.hu@gmail.com>,
 Alex Benn =?UTF-8?B?w6kg?=e <alex.bennee@linaro.org>,
 Philippe Mathieu-Daud =?UTF-8?B?w6kg?=<philmd@linaro.org>,
 Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>,
 Stefano Garzarella <sgarzare@redhat.com>, qemu-devel@nongnu.org
Subject: Re: [PATCH v12 02/11] Add virtio-sound-pci device
User-Agent: meli 0.8.2
References: <cover.1697709630.git.manos.pitsidianakis@linaro.org>
 <f68a8f30642a95f2a64a943beede32815c43fcdb.1697709630.git.manos.pitsidianakis@linaro.org>
 <235cbc94-8de9-4960-bb4d-3d861784436a@t-online.de>
 <2xdn2.m5cl6s6mv22s@linaro.org>
 <c9519870-e781-4873-a355-ca157773cc23@t-online.de>
In-Reply-To: <c9519870-e781-4873-a355-ca157773cc23@t-online.de>
Message-ID: <2z4lc.pcrxxhkf591r@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain; charset=utf-8; format=flowed
Received-SPF: pass client-ip=2a00:1450:4864:20::136;
 envelope-from=manos.pitsidianakis@linaro.org; helo=mail-lf1-x136.google.com
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

Good morning Volker,

On Sun, 22 Oct 2023 14:51, Volker Rümelin <vr_qemu@t-online.de> wrote:
>Sorry, I don't understand your last sentence. You add this alias with
>the following line in patch 02/11, so there is a virtio-sound alias.
>This alias doesn't work because there is a device with the same name.

My bad, I thought you were talking about a non-pci alias and I also did 
not express myself clearly. Sorry for the noise and thanks for spotting 
this! :) Will send a new version.

Manos

