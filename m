Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 9D5077D06C4
	for <lists+qemu-devel@lfdr.de>; Fri, 20 Oct 2023 05:15:29 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qtfxq-0006Af-4c; Thu, 19 Oct 2023 23:14:18 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <viresh.kumar@linaro.org>)
 id 1qtfxn-00069n-Ou
 for qemu-devel@nongnu.org; Thu, 19 Oct 2023 23:14:15 -0400
Received: from mail-ua1-x92c.google.com ([2607:f8b0:4864:20::92c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <viresh.kumar@linaro.org>)
 id 1qtfxm-0004DZ-3v
 for qemu-devel@nongnu.org; Thu, 19 Oct 2023 23:14:15 -0400
Received: by mail-ua1-x92c.google.com with SMTP id
 a1e0cc1a2514c-7b6043d0b82so155162241.1
 for <qemu-devel@nongnu.org>; Thu, 19 Oct 2023 20:14:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1697771652; x=1698376452; darn=nongnu.org;
 h=in-reply-to:content-transfer-encoding:content-disposition
 :mime-version:references:message-id:subject:cc:to:from:date:from:to
 :cc:subject:date:message-id:reply-to;
 bh=SmIOwafm690ltH7DS0hp8tl/3mX+luN9DZkRrNK/BHc=;
 b=po1TvuylTb767BN4eRsz3az9b2sYkJ0JEdyTFD1c7tsG2+cR8Jpii6UoJ+JNQCXwAT
 VsbuUhR3Y2nSkicicwzoY3eVTi6RA4RrkYE+7rQsAZgmqsVGGXaRhwNlm3HHGHKVnM6t
 s7Ad+FntYA7IU278PeV8BqZ3iD6PUgiqKNmLcSUssmIyXXFWohOnoKtG8lPYHayFSWpy
 oLsmjkae4kqIoObepdhdh0EefStYIQofdujR8H6gQ0xk2U2ZBZPMG2w0KX+qvJZxZvik
 DcQaFc/J1YXxn/l3gcAlsDI1siDXsaPEuXldyXh0inQ8oRwHt6pyrunluifj5lWHbJrm
 Lpog==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1697771652; x=1698376452;
 h=in-reply-to:content-transfer-encoding:content-disposition
 :mime-version:references:message-id:subject:cc:to:from:date
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=SmIOwafm690ltH7DS0hp8tl/3mX+luN9DZkRrNK/BHc=;
 b=IA8wWA0jS2u10hUY6bO5UdFEM8PW2zYNE+UnjheJUgn9i6ZlkeJ2V+AHdddnLvP2so
 e4G32ZL7tv/sm4Gwxr5uzOS9wsH1uLeLXGr/jbj/Qt9o0wwlPaz+dGkliE/Ny1TW3K1R
 nSAhqRfR8ewjrQunDrY3qpCJMvjbRAwV36UEdStluqKx0acZRFXzPbyWumNGWN3MlGfN
 NC+z0co89ldAEuGETzpkfFD0+ycglDHv/FyZ826kYEq8tIE3qJDKsEa4NiI0mGsH+XOB
 XPT/RBC9hmfP0MOonJq1+bxd8ztFaEC9fji5CFV81P9XzK4d43ncdP4BHvH/yxx5XZgb
 4WEg==
X-Gm-Message-State: AOJu0Yx2qIxuAl17nW/C3IbIWgUu187/6vkxb20GLjR4Njvm6zgEh311
 CKsDKXRaOzL4ffNK7u90xjzSWw==
X-Google-Smtp-Source: AGHT+IFk6uuV4TqJiznEMS381fAcEVlixbb0ghWNqEzuTanFfK5wmLSPOegcRaL88iMyrjJT8atHvw==
X-Received: by 2002:a67:b241:0:b0:457:d55a:cbc6 with SMTP id
 s1-20020a67b241000000b00457d55acbc6mr890221vsh.5.1697771652347; 
 Thu, 19 Oct 2023 20:14:12 -0700 (PDT)
Received: from localhost ([122.172.80.14]) by smtp.gmail.com with ESMTPSA id
 y66-20020a62ce45000000b00690ca4356f1sm506556pfg.198.2023.10.19.20.14.10
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 19 Oct 2023 20:14:11 -0700 (PDT)
Date: Fri, 20 Oct 2023 08:44:07 +0530
From: Viresh Kumar <viresh.kumar@linaro.org>
To: Alex =?utf-8?Q?Benn=C3=A9e?= <alex.bennee@linaro.org>
Cc: qemu-devel@nongnu.org,
 Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>,
 virtio-fs@redhat.com, Eduardo Habkost <eduardo@habkost.net>,
 Fam Zheng <fam@euphon.net>,
 Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>,
 qemu-block@nongnu.org, Stefan Hajnoczi <stefanha@redhat.com>,
 Gerd Hoffmann <kraxel@redhat.com>,
 Erik Schilling <erik.schilling@linaro.org>,
 "Michael S. Tsirkin" <mst@redhat.com>,
 Hanna Reitz <hreitz@redhat.com>, Eric Blake <eblake@redhat.com>,
 Kevin Wolf <kwolf@redhat.com>, Jason Wang <jasowang@redhat.com>,
 Raphael Norwitz <raphael.norwitz@nutanix.com>,
 Paolo Bonzini <pbonzini@redhat.com>,
 =?utf-8?Q?Marc-Andr=C3=A9?= Lureau <marcandre.lureau@redhat.com>,
 Markus Armbruster <armbru@redhat.com>,
 Mathieu Poirier <mathieu.poirier@linaro.org>,
 "Gonglei (Arei)" <arei.gonglei@huawei.com>,
 Manos Pitsidianakis <manos.pitsidianakis@linaro.org>
Subject: Re: [PATCH v5 5/6] hw/virtio: add vhost-user-snd and virtio-snd-pci
 devices
Message-ID: <20231020031407.xd4ykc4msfdmoav5@vireshk-i7>
References: <20231019095610.2818087-1-alex.bennee@linaro.org>
 <20231019095610.2818087-6-alex.bennee@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20231019095610.2818087-6-alex.bennee@linaro.org>
Received-SPF: pass client-ip=2607:f8b0:4864:20::92c;
 envelope-from=viresh.kumar@linaro.org; helo=mail-ua1-x92c.google.com
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

On 19-10-23, 10:56, Alex Bennée wrote:
> From: Manos Pitsidianakis <manos.pitsidianakis@linaro.org>
> 
> Tested with rust-vmm vhost-user-sound daemon:
> 
>     RUST_LOG=trace cargo run --bin vhost-user-sound -- --socket /tmp/snd.sock --backend null
> 
> Invocation:
> 
>     qemu-system-x86_64  \
>             -qmp unix:./qmp-sock,server,wait=off  \
>             -m 4096 \
>             -numa node,memdev=mem \
>             -object memory-backend-file,id=mem,size=4G,mem-path=/dev/shm,share=on \
>             -D qemu.log \
>             -d guest_errors,trace:\*snd\*,trace:\*sound\*,trace:\*vhost\* \
>             -chardev socket,id=vsnd,path=/tmp/snd.sock \
>             -device vhost-user-snd-pci,chardev=vsnd,id=snd \
>             /path/to/disk
> 
> [AJB: imported from https://github.com/epilys/qemu-virtio-snd/commit/54ae1cdd15fef2d88e9e387a175f099a38c636f4.patch]
> 
> Signed-off-by: Alex Bennée <alex.bennee@linaro.org>

Missing SOB from Manos ?

> Message-Id: <20231009095937.195728-6-alex.bennee@linaro.org>

-- 
viresh

