Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 592577E36F2
	for <lists+qemu-devel@lfdr.de>; Tue,  7 Nov 2023 09:54:50 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1r0Hqq-0005XZ-0h; Tue, 07 Nov 2023 03:54:24 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1r0Hqo-0005XQ-Nz
 for qemu-devel@nongnu.org; Tue, 07 Nov 2023 03:54:22 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1r0Hqn-0003tK-BD
 for qemu-devel@nongnu.org; Tue, 07 Nov 2023 03:54:22 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1699347260;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=o0cZ+ZhR2DJ2yBaYHFqcJusx27YTGlIT36Q55ajXsb8=;
 b=P5VY/qAOJ6cK9+jUKrGbRhqWl/qsZjy19FJvX2OKSFBs5tHgAWGeIMfo6dsn2E5jFN58HS
 AZbkwZ7vK/IIh991VT5CQEoZNiG1WLRub4dyPEU9cZaUwjCXeyd36ki3K52b3Ka4O3mtIa
 fpmLpYFIXK4JOjjwcHsnt5Zxhzh7ZbQ=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-441-4gfOXRZlMPmIhUkbjzoAng-1; Tue, 07 Nov 2023 03:54:19 -0500
X-MC-Unique: 4gfOXRZlMPmIhUkbjzoAng-1
Received: by mail-wm1-f69.google.com with SMTP id
 5b1f17b1804b1-4084163ecd9so35596185e9.3
 for <qemu-devel@nongnu.org>; Tue, 07 Nov 2023 00:54:18 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1699347258; x=1699952058;
 h=in-reply-to:content-transfer-encoding:content-disposition
 :mime-version:references:message-id:subject:cc:to:from:date
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=o0cZ+ZhR2DJ2yBaYHFqcJusx27YTGlIT36Q55ajXsb8=;
 b=tkkX9BHE0cEirzhEb5nZjRYGOM6HtoUZGb4gmEv0gdhJFbFq3ymE5phHf41jyDQDH9
 68l6Qd3CCgzGIaTxtsMi6mZlSmfWzElqb2haxhHB9cWiKYY/XERldBt4OTisuTmP0eHI
 ExEP8M2LheRYMX7QGdN22Ws6d9dnVarVpxoeuy05gXsSyNWopVAdXWtaVsU2h8hHFf8o
 G0D5lAWLBPm8mqg8WraHFYBg2KbGiXgpZSa0R7h8bEBdijgCwYlSNtMmDmuok8Y2vGlO
 k6IdLIjgI/INmnEd+d6wifDZL1/JV7SGrV7GWMVQHhYH3FBdbSL5z5YhLkduywZ4SNdl
 tW1Q==
X-Gm-Message-State: AOJu0YwJ1O4WK3hF26Zj9UqnbyP5B/IkOaPnqV9U3MP1LM3hD71Rgf7J
 bbF+VjL6f1aIg6LlxrrJLdBT2nEqnOPt4aEJaxn0DQcx1TkGArsbkooKAfZqM9NWb/OWfAiCUlQ
 uUsIK33ziGD4U7ck=
X-Received: by 2002:a05:600c:470d:b0:408:5919:5f97 with SMTP id
 v13-20020a05600c470d00b0040859195f97mr1767599wmo.25.1699347257946; 
 Tue, 07 Nov 2023 00:54:17 -0800 (PST)
X-Google-Smtp-Source: AGHT+IFW0DP4MVyvdDuQGAZ/B1lFN6dxwRGcUlEsS2knpZNuWx+hxrZ38TehffriqfgJX5UnNL3CYA==
X-Received: by 2002:a05:600c:470d:b0:408:5919:5f97 with SMTP id
 v13-20020a05600c470d00b0040859195f97mr1767586wmo.25.1699347257554; 
 Tue, 07 Nov 2023 00:54:17 -0800 (PST)
Received: from redhat.com ([2.55.5.143]) by smtp.gmail.com with ESMTPSA id
 fm15-20020a05600c0c0f00b00405391f485fsm15230888wmb.41.2023.11.07.00.54.10
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 07 Nov 2023 00:54:16 -0800 (PST)
Date: Tue, 7 Nov 2023 03:54:07 -0500
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Alex =?iso-8859-1?Q?Benn=E9e?= <alex.bennee@linaro.org>
Cc: qemu-devel@nongnu.org, Jason Wang <jasowang@redhat.com>,
 Daniel =?iso-8859-1?Q?P=2E_Berrang=E9?= <berrange@redhat.com>,
 qemu-block@nongnu.org, Markus Armbruster <armbru@redhat.com>,
 Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>,
 Stefan Hajnoczi <stefanha@redhat.com>, Gerd Hoffmann <kraxel@redhat.com>,
 "Gonglei (Arei)" <arei.gonglei@huawei.com>, virtio-fs@redhat.com,
 Hanna Reitz <hreitz@redhat.com>, Fam Zheng <fam@euphon.net>,
 Raphael Norwitz <raphael.norwitz@nutanix.com>,
 Kevin Wolf <kwolf@redhat.com>, Erik Schilling <erik.schilling@linaro.org>,
 Viresh Kumar <viresh.kumar@linaro.org>,
 Mathieu Poirier <mathieu.poirier@linaro.org>,
 Eric Blake <eblake@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>,
 =?iso-8859-1?Q?Marc-Andr=E9?= Lureau <marcandre.lureau@redhat.com>,
 Eduardo Habkost <eduardo@habkost.net>
Subject: Re: [PATCH v6 3/6] hw/virtio: derive vhost-user-gpio from
 vhost-user-base
Message-ID: <20231107035245-mutt-send-email-mst@kernel.org>
References: <20231106191515.2801863-1-alex.bennee@linaro.org>
 <20231106191515.2801863-4-alex.bennee@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20231106191515.2801863-4-alex.bennee@linaro.org>
Received-SPF: pass client-ip=170.10.129.124; envelope-from=mst@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

On Mon, Nov 06, 2023 at 07:15:12PM +0000, Alex Bennée wrote:
> -    case CHR_EVENT_CLOSED:
> -        /* defer close until later to avoid circular close */
> -        vhost_user_async_close(dev, &gpio->chardev, &gpio->vhost_dev,
> -                               vu_gpio_disconnect, vu_gpio_event);

I don't remember what is the circular close but I'd be much
calmer if this refactoring also didn't change behaviour.
Or if it does, please document why it's safe in the commit log.

-- 
MST


