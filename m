Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 99A997BD91C
	for <lists+qemu-devel@lfdr.de>; Mon,  9 Oct 2023 13:00:38 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qpnyf-0004Mj-U4; Mon, 09 Oct 2023 06:59:09 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <viresh.kumar@linaro.org>)
 id 1qpnyd-0004MB-Fd
 for qemu-devel@nongnu.org; Mon, 09 Oct 2023 06:59:07 -0400
Received: from mail-pf1-x42c.google.com ([2607:f8b0:4864:20::42c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <viresh.kumar@linaro.org>)
 id 1qpnyb-00028k-Rw
 for qemu-devel@nongnu.org; Mon, 09 Oct 2023 06:59:07 -0400
Received: by mail-pf1-x42c.google.com with SMTP id
 d2e1a72fcca58-690b7cb71aeso3182120b3a.0
 for <qemu-devel@nongnu.org>; Mon, 09 Oct 2023 03:59:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1696849144; x=1697453944; darn=nongnu.org;
 h=in-reply-to:content-transfer-encoding:content-disposition
 :mime-version:references:message-id:subject:cc:to:from:date:from:to
 :cc:subject:date:message-id:reply-to;
 bh=yd5kWI84EmbioTxJcr7Sa3qdzXv/L7GnZ6Yf4TmaOis=;
 b=TSffbhvrbYb9vDx3YyAzQpgaZDcstWTzLYzTTJMFRNhBBpuLcls3nsfPWdpgn5oh+d
 YGvExnZnWVK1qQtOoI+NTMas5Azn4lUEfbMyZqnOoQlB+0HB/hPRULnyrdSaxf4PDmkW
 pOxqx57L2cox3aegjquUfP0kKX9cbr16spi3yc30oHG/gHLNc0tTW8pJDIxmbd7necq8
 G72ruIPqzow1zsnr4AGDDbAw4vnqC8ZUwLJHE+NrTIBEHX969X2vzlXdxmKOIuQvDRrp
 3NPXTcun6ReEkhN6PXgh2ExHlBdaL6SG84+CJAoZ7Vn11c5O0YfAfNdOOQvhv+wTa7gU
 VtJw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1696849144; x=1697453944;
 h=in-reply-to:content-transfer-encoding:content-disposition
 :mime-version:references:message-id:subject:cc:to:from:date
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=yd5kWI84EmbioTxJcr7Sa3qdzXv/L7GnZ6Yf4TmaOis=;
 b=v2H9L0G2Bx4L0/4EJ/pY1UyR69C0xPnwod2BtoEaQxeInv58IUtcoyOu052HfQGft8
 QVKraIgGA7TuY3WkqQnc0iARBeN7YW9IlrJKM5s43Br14U48vH5YJW2qp1hTRaGkAHi0
 O+EwGm50Zuzf5ss/CMCq3vfT1gDwOnpG8bsEFLeisM9uP50PhT/tmpvpOrgrhDLopQPt
 rjJ8+cO5q2gFh0SCgcQb+pwWSX/LafySEK1K4DEzThAGgRDjFJuHibQ1WyS4mxr3flWc
 JkYHuMJs8ovAgqbTpzY9GQUU/KJ9cG3w79TZH5mDZVsTe3TUYcZDnSABKANEfXpBg7Pm
 a0qw==
X-Gm-Message-State: AOJu0YxpPd8cKJtpEsjO+x4sU8N4chPnYEQ7W3z7TwczLd45SOVDBTYj
 lJMEbULvaOBZzfxxrmG+yCwBWg==
X-Google-Smtp-Source: AGHT+IHtCV44pfL0jdiJVBMfV8KP/jVkvOgEOzQsd8F7GDUlpBNt6exEKL65j7x2N53/BA1Rm6s1wQ==
X-Received: by 2002:a05:6a00:1791:b0:68f:ce6a:8685 with SMTP id
 s17-20020a056a00179100b0068fce6a8685mr19073620pfg.14.1696849143846; 
 Mon, 09 Oct 2023 03:59:03 -0700 (PDT)
Received: from localhost ([122.172.81.92]) by smtp.gmail.com with ESMTPSA id
 r4-20020a62e404000000b00690d9901ce5sm6119542pfh.102.2023.10.09.03.59.02
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 09 Oct 2023 03:59:03 -0700 (PDT)
Date: Mon, 9 Oct 2023 16:29:01 +0530
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
Subject: Re: [PATCH v4 3/6] hw/virtio: derive vhost-user-gpio from
 vhost-user-base
Message-ID: <20231009105901.lmtexbfbcf5rnvch@vireshk-i7>
References: <20231009095937.195728-1-alex.bennee@linaro.org>
 <20231009095937.195728-4-alex.bennee@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20231009095937.195728-4-alex.bennee@linaro.org>
Received-SPF: pass client-ip=2607:f8b0:4864:20::42c;
 envelope-from=viresh.kumar@linaro.org; helo=mail-pf1-x42c.google.com
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
> Now the new base class supports config handling we can take advantage
> and make vhost-user-gpio a much simpler boilerplate wrapper. Also as
> this doesn't require any target specific hacks we only need to build
> the stubs once.
> 
> Message-Id: <20230418162140.373219-12-alex.bennee@linaro.org>
> Signed-off-by: Alex Bennée <alex.bennee@linaro.org>
> Acked-by: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>
> 
> ---
> v2
>   - use new vhost-user-base
>   - move build to common code
> v3
>   - fix inadvertent double link
> v4
>   - merge conflict
>   - update includes
> ---
>  include/hw/virtio/vhost-user-gpio.h |  23 +-
>  hw/virtio/vhost-user-gpio.c         | 407 ++--------------------------
>  hw/virtio/meson.build               |   5 +-
>  3 files changed, 22 insertions(+), 413 deletions(-)

Looks nice. Thanks.

Acked-by: Viresh Kumar <viresh.kumar@linaro.org>

-- 
viresh

