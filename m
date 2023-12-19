Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 9E027818791
	for <lists+qemu-devel@lfdr.de>; Tue, 19 Dec 2023 13:36:00 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rFZK5-0003JO-Cq; Tue, 19 Dec 2023 07:35:45 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <akihiko.odaki@daynix.com>)
 id 1rFZK1-0003J2-Nj
 for qemu-devel@nongnu.org; Tue, 19 Dec 2023 07:35:41 -0500
Received: from mail-pg1-x52e.google.com ([2607:f8b0:4864:20::52e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <akihiko.odaki@daynix.com>)
 id 1rFZJv-0003cn-5W
 for qemu-devel@nongnu.org; Tue, 19 Dec 2023 07:35:40 -0500
Received: by mail-pg1-x52e.google.com with SMTP id
 41be03b00d2f7-5c21e185df5so3457965a12.1
 for <qemu-devel@nongnu.org>; Tue, 19 Dec 2023 04:35:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=daynix-com.20230601.gappssmtp.com; s=20230601; t=1702989333; x=1703594133;
 darn=nongnu.org; 
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=F9Gwzcym5HWFUBbV1xeReg3XbhM69FpFbd3YyCmCWDg=;
 b=a5IiOhcbIGAhkuZwbDrU236BWjOTrOSIhabCMkIyErG6SBiz79asA8XATBbfGrtdD+
 zOLBXoZgtbKUYuSIHLGuEzq1YYpsoorTFWPzloKsn8gjjPVj8Ilhk7eHkhE/k8lhU9oW
 6qzrNrTBCb/U1pz0JyzEIepKhHWsC1GlQ1Xtu0sDVRGxy4ic3Jfiz66aET0ZU1xQtdCJ
 HJQw7hoYvO+75QrcxQ7QfkIJiZYNjenE+H1sH5BjRXVc3hlK8lS2KYQFan0L5QosWrLH
 1CI5FXtHsMkJXjdAgvg1cQXIvyGf6yc7bjhYsyhyXbnz8v9YoLLFn+G6iewbTmIiGogz
 4mQw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1702989333; x=1703594133;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=F9Gwzcym5HWFUBbV1xeReg3XbhM69FpFbd3YyCmCWDg=;
 b=N7SSwU3QBxrNiSCkkdN0rfSp79t1x4dFsnC3EgJLCXmYYF1RdR3xJzxyX+BnUdPQWI
 0fm7qoZeV8sqO2lbD27hcEZU9cPXduoVc4rCn/Cf04NKnbEyh/jheT9gi1Oq6TuoUHZL
 tspqwNYbTOhGwZ4jpMZhJb8lIcrn3TV7hDMuc9dZg2sX5sLzJBbcujjACgw/j4+pD4X+
 NNRRkY8Ln2WhU29TY7SAlzk4DGC41a8PNWO6gQ03jz1NF4CQpdTlA8qMXQ5kxx3D1jiO
 /nvIZZfEtB8bg1GJ6DE9OXchCqUvM265lO96PHmBF9Y3oELvZpOnhqLqW6rmW9vAzf9e
 kIjQ==
X-Gm-Message-State: AOJu0Yw4HOurDQNuqFs/iPvDPxEb1k+MCuTBkjYc5fmvxGhtS1eRE7GO
 I5HifdemkEsEvIX50ABreE/DbQ==
X-Google-Smtp-Source: AGHT+IHN7Cl1wf8+157FVO5wvi6ZF4ur84TuS3bmZwf9yzuEaKx9Eu+LO6bRYmp+TqjQ1Ol0YKDzIg==
X-Received: by 2002:a05:6a20:3d85:b0:191:bc5f:e803 with SMTP id
 s5-20020a056a203d8500b00191bc5fe803mr13369989pzi.72.1702989333634; 
 Tue, 19 Dec 2023 04:35:33 -0800 (PST)
Received: from [157.82.205.15] ([157.82.205.15])
 by smtp.gmail.com with ESMTPSA id
 w13-20020a170902a70d00b001c726147a46sm20886137plq.234.2023.12.19.04.35.28
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 19 Dec 2023 04:35:33 -0800 (PST)
Message-ID: <3105531c-bfc4-4421-a197-4ab8ddb9f4a5@daynix.com>
Date: Tue, 19 Dec 2023 21:35:27 +0900
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v6 05/11] virtio-gpu: Introduce virgl_gpu_resource
 structure
Content-Language: en-US
To: Huang Rui <ray.huang@amd.com>,
 =?UTF-8?Q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@gmail.com>,
 =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Gerd Hoffmann <kraxel@redhat.com>, "Michael S . Tsirkin" <mst@redhat.com>,
 Stefano Stabellini <sstabellini@kernel.org>,
 Anthony PERARD <anthony.perard@citrix.com>,
 Antonio Caggiano <quic_acaggian@quicinc.com>,
 "Dr . David Alan Gilbert" <dgilbert@redhat.com>,
 Robert Beckett <bob.beckett@collabora.com>,
 Dmitry Osipenko <dmitry.osipenko@collabora.com>,
 Gert Wollny <gert.wollny@collabora.com>, =?UTF-8?Q?Alex_Benn=C3=A9e?=
 <alex.bennee@linaro.org>, qemu-devel@nongnu.org
Cc: xen-devel@lists.xenproject.org,
 Gurchetan Singh <gurchetansingh@chromium.org>, ernunes@redhat.com,
 Alyssa Ross <hi@alyssa.is>, =?UTF-8?Q?Roger_Pau_Monn=C3=A9?=
 <roger.pau@citrix.com>, Alex Deucher <alexander.deucher@amd.com>,
 Stefano Stabellini <stefano.stabellini@amd.com>,
 =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>,
 Xenia Ragiadakou <xenia.ragiadakou@amd.com>,
 Pierre-Eric Pelloux-Prayer <pierre-eric.pelloux-prayer@amd.com>,
 Honglei Huang <honglei1.huang@amd.com>, Julia Zhang <julia.zhang@amd.com>,
 Chen Jiqian <Jiqian.Chen@amd.com>
References: <20231219075320.165227-1-ray.huang@amd.com>
 <20231219075320.165227-6-ray.huang@amd.com>
From: Akihiko Odaki <akihiko.odaki@daynix.com>
In-Reply-To: <20231219075320.165227-6-ray.huang@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: none client-ip=2607:f8b0:4864:20::52e;
 envelope-from=akihiko.odaki@daynix.com; helo=mail-pg1-x52e.google.com
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_NONE=0.001, T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

On 2023/12/19 16:53, Huang Rui wrote:
> Introduce a new virgl_gpu_resource data structure and helper functions
> for virgl. It's used to add new member which is specific for virgl in
> following patches of blob memory support.

The name is ambigious. It should tell that it's specific for virgl.

