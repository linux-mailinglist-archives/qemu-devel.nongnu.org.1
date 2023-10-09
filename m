Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 9CD597BD91D
	for <lists+qemu-devel@lfdr.de>; Mon,  9 Oct 2023 13:00:38 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qpnyv-0004Qs-PW; Mon, 09 Oct 2023 06:59:25 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <viresh.kumar@linaro.org>)
 id 1qpnyt-0004QV-Vp
 for qemu-devel@nongnu.org; Mon, 09 Oct 2023 06:59:23 -0400
Received: from mail-pl1-x633.google.com ([2607:f8b0:4864:20::633])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <viresh.kumar@linaro.org>)
 id 1qpnys-0002GB-Ik
 for qemu-devel@nongnu.org; Mon, 09 Oct 2023 06:59:23 -0400
Received: by mail-pl1-x633.google.com with SMTP id
 d9443c01a7336-1c5cd27b1acso34685095ad.2
 for <qemu-devel@nongnu.org>; Mon, 09 Oct 2023 03:59:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1696849161; x=1697453961; darn=nongnu.org;
 h=in-reply-to:content-transfer-encoding:content-disposition
 :mime-version:references:message-id:subject:cc:to:from:date:from:to
 :cc:subject:date:message-id:reply-to;
 bh=nAOqsSFr3jk7+N7ZTVaXa68g9aRWhZNiRtd02Vd5zi4=;
 b=OTWzfoNNlrOc1xZuzrlHfkn+W5cNc1EyZylH0EFmsvPf7q4dWSuNKyYNe/xGlrZPH/
 mTj2Tc3WmYOK5HXj6rlSUpV3zabO8PnXbDPrZ2Gy6dU4SUv6yGTRYZSXI3/X3YxpTvLX
 h9RudGS9sTBKQV/aaA8LAuxr90kqxnl/T6gmkOtC/X3mA0zWG5rQdV0fOQc8OtAULYL/
 KmC5hq2jQiIzdG/3/mKTpoFQb3CtCzmCeFkDmYTtJzH20fmPc4aT5tr9n7nJFPVgCmF5
 bdYCSkPNF66EwjY4FyuseHd+5+BL0IPGDlVhcYoPIHiQim0/a1cKZaDPLEhY9f7IICqz
 bxpw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1696849161; x=1697453961;
 h=in-reply-to:content-transfer-encoding:content-disposition
 :mime-version:references:message-id:subject:cc:to:from:date
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=nAOqsSFr3jk7+N7ZTVaXa68g9aRWhZNiRtd02Vd5zi4=;
 b=mvM57gcEHEX12qiIJ4jyADa9TajiBUwBgsxpZpKZdvjuVqRAz76g2Sidcc+SKTlEQy
 ioRwIo3k5wgsq5uAlEMGCbxszqXegl+5gDi2xmNkwboP6IRjMnBLiAh5AQJ1KfrzSm2z
 +oMAco3uszm/xigqn3CnKut5XK84x119udZ6CUJLiJVnqdxW1b5wAw7ugHRs1RCM9cLz
 MDzQCLVjttgH99DsKAfS6sYFBDDGgNS8+dChrpknLtjhLFr4wNWfTZ3V3rt8OQFuy9kf
 GHT/Usta5mF673YGT++2vXSa7ALOEAAfhfbvyzyASrtNPyBDJIBFMyauT4QLpVN63+rS
 TmcA==
X-Gm-Message-State: AOJu0YxzLK9p9ZQfTW3N22UqFWcvUFogiZSfPLyKIh1qr9lzuQtWJWS/
 kQv5leCUXc7endi/IPEQ7yJz7g==
X-Google-Smtp-Source: AGHT+IHQoTNG+ZemzZzFTzRh3HTOItv3hvDhj2dKdtYwExo2UYpkq/v0ClrFx9ECDAtaGftl5PVoYw==
X-Received: by 2002:a17:902:e547:b0:1c7:56d8:9068 with SMTP id
 n7-20020a170902e54700b001c756d89068mr17952356plf.31.1696849161176; 
 Mon, 09 Oct 2023 03:59:21 -0700 (PDT)
Received: from localhost ([122.172.81.92]) by smtp.gmail.com with ESMTPSA id
 h3-20020a170902704300b001c73d829fb0sm9231503plt.32.2023.10.09.03.59.20
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 09 Oct 2023 03:59:20 -0700 (PDT)
Date: Mon, 9 Oct 2023 16:29:18 +0530
From: Viresh Kumar <viresh.kumar@linaro.org>
To: Alex =?utf-8?Q?Benn=C3=A9e?= <alex.bennee@linaro.org>
Cc: qemu-devel@nongnu.org,
 =?utf-8?Q?Marc-Andr=C3=A9?= Lureau <marcandre.lureau@redhat.com>,
 Erik Schilling <erik.schilling@linaro.org>, Fam Zheng <fam@euphon.net>,
 Mathieu Poirier <mathieu.poirier@linaro.org>,
 Gerd Hoffmann <kraxel@redhat.com>, Hanna Reitz <hreitz@redhat.com>,
 Stefan Hajnoczi <stefanha@redhat.com>,
 Kevin Wolf <kwolf@redhat.com>, Eric Blake <eblake@redhat.com>,
 "Michael S. Tsirkin" <mst@redhat.com>, qemu-block@nongnu.org,
 Eduardo Habkost <eduardo@habkost.net>, Paolo Bonzini <pbonzini@redhat.com>,
 Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>,
 virtio-fs@redhat.com, "Gonglei (Arei)" <arei.gonglei@huawei.com>,
 Markus Armbruster <armbru@redhat.com>, Jason Wang <jasowang@redhat.com>,
 Raphael Norwitz <raphael.norwitz@nutanix.com>,
 Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
Subject: Re: [PATCH v4 4/6] hw/virtio: derive vhost-user-i2c from
 vhost-user-base
Message-ID: <20231009105918.tvji5lsw5jrt4gur@vireshk-i7>
References: <20231009095937.195728-1-alex.bennee@linaro.org>
 <20231009095937.195728-5-alex.bennee@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20231009095937.195728-5-alex.bennee@linaro.org>
Received-SPF: pass client-ip=2607:f8b0:4864:20::633;
 envelope-from=viresh.kumar@linaro.org; helo=mail-pl1-x633.google.com
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

On 09-10-23, 10:59, Alex Bennée wrote:
> Now we can take advantage of the new base class and make
> vhost-user-i2c a much simpler boilerplate wrapper. Also as this
> doesn't require any target specific hacks we only need to build the
> stubs once.
> 
> Message-Id: <20230418162140.373219-13-alex.bennee@linaro.org>
> Acked-by: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>
> Signed-off-by: Alex Bennée <alex.bennee@linaro.org>
> 
> ---
> v2
>   - update to new inheritance scheme
>   - move build to common code
> v3
>   - fix merge conflict in meson
>   - style updates, remove duplicate includes
> v4
>   - use vqsize
> ---
>  include/hw/virtio/vhost-user-i2c.h |  14 +-
>  hw/virtio/vhost-user-i2c.c         | 272 ++---------------------------
>  hw/virtio/meson.build              |   5 +-
>  3 files changed, 23 insertions(+), 268 deletions(-)

Acked-by: Viresh Kumar <viresh.kumar@linaro.org>

-- 
viresh

