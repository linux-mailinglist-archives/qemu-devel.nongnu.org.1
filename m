Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id A4AF37F0B89
	for <lists+qemu-devel@lfdr.de>; Mon, 20 Nov 2023 06:21:09 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1r4whQ-0006vy-HU; Mon, 20 Nov 2023 00:19:58 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <manos.pitsidianakis@linaro.org>)
 id 1r4whF-0006vp-R4
 for qemu-devel@nongnu.org; Mon, 20 Nov 2023 00:19:46 -0500
Received: from mail-wr1-x42d.google.com ([2a00:1450:4864:20::42d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <manos.pitsidianakis@linaro.org>)
 id 1r4whE-0001Rx-6M
 for qemu-devel@nongnu.org; Mon, 20 Nov 2023 00:19:45 -0500
Received: by mail-wr1-x42d.google.com with SMTP id
 ffacd0b85a97d-32d9d8284abso2603862f8f.3
 for <qemu-devel@nongnu.org>; Sun, 19 Nov 2023 21:19:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1700457581; x=1701062381; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:in-reply-to
 :references:user-agent:subject:cc:to:from:date:from:to:cc:subject
 :date:message-id:reply-to;
 bh=Hq7MazmFIdUvQb7Ddv/iRa6ufG70Qi3uHKKiWgtvi6k=;
 b=BOES1lTbfN4yD7h8Qlz4shaa457NBxI2kAlFf8y1BFm1lizpS/9u2i1Hiq4DiN02bk
 F5kfUMT7C4kqg7uMYc6v2LnZqXGDjDSYcTG5SdCK48J9Fqq1GXZVyirZUYi12Pv6/Wlz
 +vWsy4YBkRSZ0Oad0vPmKzmFO0g8v60oucwEsASmQh4cy7PT8BXKlS/lBn7pEeHgTrj6
 1Lxi1TKFyS07Nmxhk/d+8/3xmx5fHpowiUH8VrcN6DxF0bN0pOezUKyCX/53tkUzSYAH
 xA5aYR7EivJ94DDIwRKsFz/k9QJV5IgPCBmih1kYYhHSh+hOUO/nqxQQR8HUC42xlTuY
 R8xw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1700457581; x=1701062381;
 h=content-transfer-encoding:mime-version:message-id:in-reply-to
 :references:user-agent:subject:cc:to:from:date:x-gm-message-state
 :from:to:cc:subject:date:message-id:reply-to;
 bh=Hq7MazmFIdUvQb7Ddv/iRa6ufG70Qi3uHKKiWgtvi6k=;
 b=Rgeytb77KVv6YCuG3OKist+tUaI/R52SvjTl9SghHyrR7hQ2HJDpP2Xq4ja3BcmQAy
 jeS4J8qC21UWUbtm2yZozb/rvFj/zjOE3fO8yd/37OGM1bg8JOHI4FlS1kAIWWTL3JcF
 oJm87vMjTlNOocw6VlgkZoEhefgCMFHFKZthDCaDa6F8sDqPq9akHRpORyPexRxZrLCw
 WhFT63yo6E5ZE8Pcc44cB1uahYKHO5Z11qXA8Ub4+jg/QS//kOKaS6GS/AnV7ltPSaEz
 yowiG6y7lXO9i7+nOb94TNa29QGA2Z5n5+9WKyC3v4f/Q54o1Xj9S48Jqhd+T/Q+7Qpj
 VkLg==
X-Gm-Message-State: AOJu0YxExptrBGGiPe/5JYCmpuIrb7GyvFIPRSUkuw4Mv1I2peWmCGWt
 GhR17PyUhtyqYvnB5DRxw3W6KA==
X-Google-Smtp-Source: AGHT+IHb8MPEO80YKUcmTjuES73UTZAit2qSkL+0bJ79rZJ+QFfKfDlWVM4LFd7k5XI1IZ/5vlllNw==
X-Received: by 2002:adf:ce0c:0:b0:32d:e6ec:2862 with SMTP id
 p12-20020adfce0c000000b0032de6ec2862mr3133247wrn.7.1700457581631; 
 Sun, 19 Nov 2023 21:19:41 -0800 (PST)
Received: from meli.delivery (adsl-27.37.6.163.tellas.gr. [37.6.163.27])
 by smtp.gmail.com with ESMTPSA id
 d5-20020adfef85000000b0032fb46812c2sm9861094wro.12.2023.11.19.21.19.40
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 19 Nov 2023 21:19:40 -0800 (PST)
Date: Mon, 20 Nov 2023 07:17:50 +0200
From: Manos Pitsidianakis <manos.pitsidianakis@linaro.org>
To: Leo Yan <leo.yan@linaro.org>, qemu-devel@nongnu.org
Cc: Alex Benn=?UTF-8?B?w6k=?= e <alex.bennee@linaro.org>,
 Gerd Hoffmann <kraxel@redhat.com>, "Michael S . Tsirkin" <mst@redhat.com>,
 Manos Pitsidianakis <manos.pitsidianakis@linaro.org>,
 Marc-Andr=?UTF-8?B?w6kg?=Lureau <marcandre.lureau@redhat.com>,
 Leo Yan <leo.yan@linaro.org>
Subject: Re: [PATCH v3 3/4] hw/virtio: Move vhost-user-input into virtio folder
User-Agent: meli 0.8.2
References: <20231120043721.50555-1-leo.yan@linaro.org>
 <20231120043721.50555-4-leo.yan@linaro.org>
In-Reply-To: <20231120043721.50555-4-leo.yan@linaro.org>
Message-ID: <4epgq.rzp5z0yl05ln@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain; charset=utf-8; format=flowed
Received-SPF: pass client-ip=2a00:1450:4864:20::42d;
 envelope-from=manos.pitsidianakis@linaro.org; helo=mail-wr1-x42d.google.com
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

On Mon, 20 Nov 2023 06:37, Leo Yan <leo.yan@linaro.org> wrote:
>vhost-user-input is in the input folder.  On the other hand, the folder
>'hw/virtio' maintains other virtio stubs (e.g. I2C, RNG, GPIO, etc).
>
>This patch moves vhost-user-input into the virtio folder for better code
>organization.  No functionality change.
>
>Signed-off-by: Leo Yan <leo.yan@linaro.org>

Reviewed-by: Manos Pitsidianakis <manos.pitsidianakis@linaro.org>

