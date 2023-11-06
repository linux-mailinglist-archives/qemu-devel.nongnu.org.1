Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 3AE697E2B82
	for <lists+qemu-devel@lfdr.de>; Mon,  6 Nov 2023 18:55:45 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1r03ne-0004sR-Nv; Mon, 06 Nov 2023 12:54:11 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1r03nb-0004rP-I0
 for qemu-devel@nongnu.org; Mon, 06 Nov 2023 12:54:07 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1r03nK-0008Uy-92
 for qemu-devel@nongnu.org; Mon, 06 Nov 2023 12:54:07 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1699293226;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=NSPKmRcoSYURof/MZl2gT7mo7AFMQZkD3uSnHmbHdDA=;
 b=LHwhs9Q0dD7+CgLqhhf2CdPJGpsTZEoujANUT043VorKg+L0UWB6EEiTJbWKr9OFZgUCyp
 yr+R8lr6X6oJ3m4MaPyuYUxVSSk6D5Wggz0xE1DA/s1f9DQlGdxtt4r7iAfwpmmU/Yg+XS
 r3lYGfI+NHWjcef6VoU5GhGqIKPG+RU=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-282-XFr2N0IEPzSWCzEZQ_vetw-1; Mon, 06 Nov 2023 12:53:45 -0500
X-MC-Unique: XFr2N0IEPzSWCzEZQ_vetw-1
Received: by mail-wm1-f70.google.com with SMTP id
 5b1f17b1804b1-4094d1e52daso31057985e9.2
 for <qemu-devel@nongnu.org>; Mon, 06 Nov 2023 09:53:45 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1699293223; x=1699898023;
 h=in-reply-to:content-transfer-encoding:content-disposition
 :mime-version:references:message-id:subject:cc:to:from:date
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=NSPKmRcoSYURof/MZl2gT7mo7AFMQZkD3uSnHmbHdDA=;
 b=vFrW4OD6WWxO5OOm4+OnXougGqsCuSvlp9wmuRWfZrHr9tzT6wMZG/TmWab7GuIIto
 hys10x4sYzzhuCkAPN1ea1NLZF5MZG/UR/Rc4nmeuS4OZcb3NWQ8YWvpznWT7SpotZPr
 6+umhCXZz4sr1fJdT8JAF13NIuTsUl6+3kQeOrkz3HsTNCoDc4DowhMplkEnpT4FtKc8
 7KLI6GKHl43W9qGBuijWIzOzThaai7E1EVWHuaFii8UmjYuGvDe1afymlTyi/hUvsKs3
 eO/3SWds2umJ1dr+fxUDUr5F70RmKNsPT7VdieY/STE0yWKEWldE4VgtmoEQibZBIexu
 cVyA==
X-Gm-Message-State: AOJu0Yzp/0/haWO5PaQYKhCytlzjnA4Osk/meHaLv8AqddY5ZXD3Rey4
 PAfbvdbiFaI+waB/5cF6mjf3RlvWaQyVk75yr8teEqcZOAvipKSLiRuO00tbol5+xCu3D47jTSX
 WO28LbCS13bGWHv/9+yBozJs=
X-Received: by 2002:a05:600c:3115:b0:401:23fc:1f92 with SMTP id
 g21-20020a05600c311500b0040123fc1f92mr343448wmo.25.1699293223696; 
 Mon, 06 Nov 2023 09:53:43 -0800 (PST)
X-Google-Smtp-Source: AGHT+IE2KiY9lMwj673jwmw8ZBXdQ5if0xuJRwaAe9amrdlKYfYd+OtqPcje3sTH5QCKF7pwP7yYJQ==
X-Received: by 2002:a05:600c:3115:b0:401:23fc:1f92 with SMTP id
 g21-20020a05600c311500b0040123fc1f92mr343435wmo.25.1699293223349; 
 Mon, 06 Nov 2023 09:53:43 -0800 (PST)
Received: from redhat.com ([5.102.242.158]) by smtp.gmail.com with ESMTPSA id
 n5-20020a05600c3b8500b004064e3b94afsm13194408wms.4.2023.11.06.09.53.40
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 06 Nov 2023 09:53:42 -0800 (PST)
Date: Mon, 6 Nov 2023 12:53:39 -0500
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Alex =?iso-8859-1?Q?Benn=E9e?= <alex.bennee@linaro.org>
Cc: qemu-devel@nongnu.org,
 Daniel =?iso-8859-1?Q?P=2E_Berrang=E9?= <berrange@redhat.com>,
 virtio-fs@redhat.com, Eduardo Habkost <eduardo@habkost.net>,
 Fam Zheng <fam@euphon.net>,
 Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>,
 qemu-block@nongnu.org, Stefan Hajnoczi <stefanha@redhat.com>,
 Gerd Hoffmann <kraxel@redhat.com>,
 Erik Schilling <erik.schilling@linaro.org>,
 Hanna Reitz <hreitz@redhat.com>, Eric Blake <eblake@redhat.com>,
 Kevin Wolf <kwolf@redhat.com>, Jason Wang <jasowang@redhat.com>,
 Raphael Norwitz <raphael.norwitz@nutanix.com>,
 Paolo Bonzini <pbonzini@redhat.com>,
 =?iso-8859-1?Q?Marc-Andr=E9?= Lureau <marcandre.lureau@redhat.com>,
 Markus Armbruster <armbru@redhat.com>,
 Mathieu Poirier <mathieu.poirier@linaro.org>,
 Viresh Kumar <viresh.kumar@linaro.org>,
 "Gonglei (Arei)" <arei.gonglei@huawei.com>
Subject: Re: [PATCH v5 3/6] hw/virtio: derive vhost-user-gpio from
 vhost-user-base
Message-ID: <20231106125222-mutt-send-email-mst@kernel.org>
References: <20231019095610.2818087-1-alex.bennee@linaro.org>
 <20231019095610.2818087-4-alex.bennee@linaro.org>
 <20231106121400-mutt-send-email-mst@kernel.org>
 <87ttpybxhc.fsf@draig.linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <87ttpybxhc.fsf@draig.linaro.org>
Received-SPF: pass client-ip=170.10.133.124; envelope-from=mst@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
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

On Mon, Nov 06, 2023 at 05:30:39PM +0000, Alex Bennée wrote:
> "Michael S. Tsirkin" <mst@redhat.com> writes:
> 
> > On Thu, Oct 19, 2023 at 10:56:07AM +0100, Alex Bennée wrote:
> >> Now the new base class supports config handling we can take advantage
> >> and make vhost-user-gpio a much simpler boilerplate wrapper. Also as
> >> this doesn't require any target specific hacks we only need to build
> >> the stubs once.
> >> 
> >> Message-Id: <20230418162140.373219-12-alex.bennee@linaro.org>
> >> Acked-by: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>
> >> Acked-by: Viresh Kumar <viresh.kumar@linaro.org>
> >> Signed-off-by: Alex Bennée <alex.bennee@linaro.org>
> >> Message-Id: <20231009095937.195728-4-alex.bennee@linaro.org>
> >> ---
> >> -    case CHR_EVENT_OPENED:
> >> -        if (vu_gpio_connect(dev, &local_err) < 0) {
> >> -            qemu_chr_fe_disconnect(&gpio->chardev);
> >> -            return;
> >> -        }
> >> -        break;
> >> -    case CHR_EVENT_CLOSED:
> >> -        /* defer close until later to avoid circular close */
> >> -        vhost_user_async_close(dev, &gpio->chardev, &gpio->vhost_dev,
> >> -                               vu_gpio_disconnect);
> >
> > Hmm. Looking at this, it seems that the base device will handle close
> > synchronously. No? Why isn't this a problem?
> 
> I suspect it was a copy and paste from another vhost-user impl. But
> testing has shown it works ok.

Can you rebase on latest master then please? There have been
changes exactly in this area.


-- 
MST


