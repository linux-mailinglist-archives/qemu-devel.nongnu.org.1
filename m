Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 3AC80793809
	for <lists+qemu-devel@lfdr.de>; Wed,  6 Sep 2023 11:24:09 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qdojf-0005JW-9A; Wed, 06 Sep 2023 05:22:07 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mvaralar@redhat.com>)
 id 1qdojQ-00056S-Iv
 for qemu-devel@nongnu.org; Wed, 06 Sep 2023 05:21:56 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mvaralar@redhat.com>)
 id 1qdojJ-0006rp-7S
 for qemu-devel@nongnu.org; Wed, 06 Sep 2023 05:21:47 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1693992103;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=NFXjvBMS99021FrdcfPfECSYQPRb3g9H6ctIwdJYTbk=;
 b=hbQ6oqVO9HDhLbcvjLSOqQg1XUgkx0JErsSQTpQgTUMSl8U0jyysOM2yGX3jrzX5O6oqc7
 07ORKgjBJOifaKoDoytgT+WogKqujjNRXPNG0OBp3SiXVsp0bQkv01jIRZ15Yphj/Z0kIW
 vsGvIOGWDiV3vzclt3t+7hbs0vD33so=
Received: from mail-qv1-f72.google.com (mail-qv1-f72.google.com
 [209.85.219.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-363-jpg6JBpkNJqtwEkEC8s4qA-1; Wed, 06 Sep 2023 05:21:42 -0400
X-MC-Unique: jpg6JBpkNJqtwEkEC8s4qA-1
Received: by mail-qv1-f72.google.com with SMTP id
 6a1803df08f44-64f412e568eso37921436d6.0
 for <qemu-devel@nongnu.org>; Wed, 06 Sep 2023 02:21:42 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1693992102; x=1694596902;
 h=in-reply-to:content-transfer-encoding:content-disposition
 :mime-version:references:message-id:subject:cc:to:from:date
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=NFXjvBMS99021FrdcfPfECSYQPRb3g9H6ctIwdJYTbk=;
 b=OZqm+b/YJTmAuecswvO2y83GdI5UqZK0HmrS7adqB5V2AFIcGsy09THoucn2XZ7Dam
 DhERTwJDAhn4mLpaTWt7Tv9OvFX2cuZ0K8ORrJgpvJM7HoHmXl+AU/cI2eWr67eSrdXs
 cN/AE7uW1x8RrHUSPYGCfBRSKsBV/pyLRGB4LAuTWAH6YXbyxhZHRmNiGZoBsTTNiebn
 O3PYNsv6Ee8iJFzCX5GFiA4h+vxvQ9DrzEMOLHWvq/QO9vNU5CLs5jM7WO1bmolwxPcr
 Id6835f3cbWiD6QaclEKsjtVZ3sFwrqTlhl0psOoFs1odmbfPVRN0RNGz9rh8MinbJ/p
 VF+g==
X-Gm-Message-State: AOJu0Yw8IALHZ+WsaG2jMcB04uNCgzWoAEo8ZXgcEeqyHdhf6KiiFJlM
 BriLiN+ae6FY4a9MfaSm9fcFLAJD54FYSDn53ygN9FR440OIWZUz4XijdOhB9xI2EE8Fqr7JA6g
 0i/Ry6hAl2+LOE40=
X-Received: by 2002:a0c:f28a:0:b0:633:45e2:5603 with SMTP id
 k10-20020a0cf28a000000b0063345e25603mr16651645qvl.60.1693992102042; 
 Wed, 06 Sep 2023 02:21:42 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGue1RNlRbHNMFIw70oxK3klHeInKWoGR6UdbboyIHWUrY/wzLP0+KbWr9WN1MP55XqfHwaeg==
X-Received: by 2002:a0c:f28a:0:b0:633:45e2:5603 with SMTP id
 k10-20020a0cf28a000000b0063345e25603mr16651608qvl.60.1693992101733; 
 Wed, 06 Sep 2023 02:21:41 -0700 (PDT)
Received: from fedora ([2a01:e0a:257:8c60:80f1:cdf8:48d0:b0a1])
 by smtp.gmail.com with ESMTPSA id
 p5-20020a0cf545000000b0064f42b1ab05sm5345707qvm.39.2023.09.06.02.21.38
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 06 Sep 2023 02:21:41 -0700 (PDT)
Date: Wed, 6 Sep 2023 11:21:36 +0200
From: Matias Ezequiel Vara Larsen <mvaralar@redhat.com>
To: Alex =?iso-8859-1?Q?Benn=E9e?= <alex.bennee@linaro.org>
Cc: qemu-devel@nongnu.org,
 =?iso-8859-1?Q?Marc-Andr=E9?= Lureau <marcandre.lureau@redhat.com>,
 Jason Wang <jasowang@redhat.com>, Viresh Kumar <viresh.kumar@linaro.org>,
 Raphael Norwitz <raphael.norwitz@nutanix.com>,
 Paolo Bonzini <pbonzini@redhat.com>,
 Daniel =?iso-8859-1?Q?P=2E_Berrang=E9?= <berrange@redhat.com>,
 qemu-block@nongnu.org, Eric Blake <eblake@redhat.com>,
 "Michael S. Tsirkin" <mst@redhat.com>,
 Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>,
 Kevin Wolf <kwolf@redhat.com>, Markus Armbruster <armbru@redhat.com>,
 Gerd Hoffmann <kraxel@redhat.com>,
 Mathieu Poirier <mathieu.poirier@linaro.org>,
 Hanna Reitz <hreitz@redhat.com>,
 Erik Schilling <erik.schilling@linaro.org>,
 "Gonglei (Arei)" <arei.gonglei@huawei.com>,
 Eduardo Habkost <eduardo@habkost.net>, Fam Zheng <fam@euphon.net>,
 virtio-fs@redhat.com, Stefan Hajnoczi <stefanha@redhat.com>
Subject: Re: [PATCH v3 07/20] virtio: add vhost-user-base and a generic
 vhost-user-device
Message-ID: <ZPhEoP8/PYUQG8Ri@fedora>
References: <20230710153522.3469097-1-alex.bennee@linaro.org>
 <20230710153522.3469097-8-alex.bennee@linaro.org>
 <ZPc44//qJCPNAOXE@fedora> <87ledkh7q7.fsf@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <87ledkh7q7.fsf@linaro.org>
Received-SPF: pass client-ip=170.10.129.124; envelope-from=mvaralar@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

On Tue, Sep 05, 2023 at 06:01:56PM +0100, Alex Bennée wrote:
> 
> Matias Ezequiel Vara Larsen <mvaralar@redhat.com> writes:
> 
> > On Mon, Jul 10, 2023 at 04:35:09PM +0100, Alex Bennée wrote:
> >> In theory we shouldn't need to repeat so much boilerplate to support
> >> vhost-user backends. This provides a generic vhost-user-base QOM
> >> object and a derived vhost-user-device for which the user needs to
> >> provide the few bits of information that aren't currently provided by
> >> the vhost-user protocol. This should provide a baseline implementation
> >> from which the other vhost-user stub can specialise.
> >> 
> >> Signed-off-by: Alex Bennée <alex.bennee@linaro.org>
> >> 
> >> ---
> >> v2
> >>   - split into vub and vud
> <snip>
> >> +
> >> +    /*
> >> +     * Disable guest notifiers, by default all notifications will be via the
> >> +     * asynchronous vhost-user socket.
> >> +     */
> >> +    vdev->use_guest_notifier_mask = false;
> >> +
> >> +    /* Allocate queues */
> >> +    vub->vqs = g_ptr_array_sized_new(vub->num_vqs);
> >> +    for (int i = 0; i < vub->num_vqs; i++) {
> >> +        g_ptr_array_add(vub->vqs,
> >> +                        virtio_add_queue(vdev, 4, vub_handle_output));
> >> +    }
> >> +
> >
> > Hello Alex, apologies if someone already asked this. If I understand
> > correctly, the second parameter of virtio_add_queue() is the len of the
> > queue. Why have you chosen "4" as its value? Shall qemu query the len of
> > the queue from the vhost-user device instead?
> 
> Hmm yeah that is inherited from the virtio-rng backend which has a
> pretty short queue. I don't think it is intrinsic to the device
> implementation (although I guess that depends if a device will have
> multiple requests in flight).
> 
> I propose making is some useful ^2 (like 64) and adding a config knob to
> increase it if needed.
> 

LGTM.  

Matias


