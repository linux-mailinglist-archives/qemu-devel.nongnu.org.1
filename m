Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 3E09B92BCB5
	for <lists+qemu-devel@lfdr.de>; Tue,  9 Jul 2024 16:19:12 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sRBfS-0003AT-5d; Tue, 09 Jul 2024 10:18:06 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mvaralar@redhat.com>)
 id 1sRBfQ-00039J-Ah
 for qemu-devel@nongnu.org; Tue, 09 Jul 2024 10:18:04 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mvaralar@redhat.com>)
 id 1sRBfO-00013I-Iy
 for qemu-devel@nongnu.org; Tue, 09 Jul 2024 10:18:04 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1720534681;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=ipIlhoNQR3fpiMKxIi+pla3QO9ZNHfvjrx04SQTe76E=;
 b=W3fRfQjC6jfntele/cBxrHB9rIlBG+qrlHRHqri1L4PXjxqLytU3A1aO/S2bfe5jqeHPqB
 VpSpVQ78OzQ6zx4oUkvSdZ9KhraxF5F8oEvFh3oFaETpAmnHh7OZRhn70U0+CjoJWRaPF+
 VTFSQPocwGDkqV1JmIS0Wu2PLiCtRYY=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-441-tP3Up8sCP863FEabFu7JhA-1; Tue, 09 Jul 2024 10:16:31 -0400
X-MC-Unique: tP3Up8sCP863FEabFu7JhA-1
Received: by mail-wm1-f69.google.com with SMTP id
 5b1f17b1804b1-4256667ebf9so38867725e9.1
 for <qemu-devel@nongnu.org>; Tue, 09 Jul 2024 07:16:31 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1720534590; x=1721139390;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=ipIlhoNQR3fpiMKxIi+pla3QO9ZNHfvjrx04SQTe76E=;
 b=hLojaywaRbtF4CdVUgPuOqC3nsxjAJHhNs6sgvTDSk0CdzUxcQSuJeM7jJ75NKAhN3
 WO+v6CeldCEdT2rPhly4I7uxIS/BHRCvVlwY6KX2ZI0X65dVvdJ4VSsGizg8oADa/odK
 GbAl9yh51NkUtM91BkIpzUL54B7hY9yKI60YUVuNU25OfFEBehvSkYA6RldKDmKLjuJ0
 3QfyGEAIZTvA/we+eQVIW28xtWgeUnesJ+1ftzrzx9yqkP5yTg8WN2Z6xbbMc6v2Grzx
 12205NvQmkkZLbezU5ZaB2dfSQ5rBI9xC1tNAPTPdiImx4ACdpngbisMU5sht2Zbq5AU
 h73g==
X-Gm-Message-State: AOJu0YxjhpHyo/mVw7tJPEFpWmNpqXcT0PxOn5ty/21U5ApI+SACQnPj
 XyAXUdl+wPU94x656Xi53h6XDeGrPBeg/dmYKMAa7Oqo1XYjUrqC4sowb+krWi6IfjRhAbiv9Tm
 JqbA+O10WP56LZaMIhG4A40wNfoajOTNEfJOb7SN9ys0EyrzgYxp3
X-Received: by 2002:a05:600c:4655:b0:426:58ca:9ef4 with SMTP id
 5b1f17b1804b1-426708f102amr17124785e9.40.1720534590574; 
 Tue, 09 Jul 2024 07:16:30 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHpToNd6kCi77auS9aDA94pRWxcdb+pwP7GbXFb9BVpYowCYUJY+oAR0mBNVxHiazlmctFAgg==
X-Received: by 2002:a05:600c:4655:b0:426:58ca:9ef4 with SMTP id
 5b1f17b1804b1-426708f102amr17124585e9.40.1720534590222; 
 Tue, 09 Jul 2024 07:16:30 -0700 (PDT)
Received: from fedora ([2a01:e0a:257:8c60:80f1:cdf8:48d0:b0a1])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4266f6f5f25sm43481385e9.26.2024.07.09.07.16.29
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 09 Jul 2024 07:16:29 -0700 (PDT)
Date: Tue, 9 Jul 2024 16:16:27 +0200
From: Matias Ezequiel Vara Larsen <mvaralar@redhat.com>
To: Manos Pitsidianakis <manos.pitsidianakis@linaro.org>
Cc: qemu-devel@nongnu.org, qemu-stable@nongnu.org,
 Thomas Huth <thuth@redhat.com>,
 Philippe =?iso-8859-1?Q?Mathieu-Daud=E9?= <philmd@linaro.org>,
 Gustavo Romero <gustavo.romero@linaro.org>,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>,
 Zheyu Ma <zheyuma97@gmail.com>, "Michael S. Tsirkin" <mst@redhat.com>,
 Gerd Hoffmann <kraxel@redhat.com>
Subject: Re: [PATCH v1 1/1] virtio-snd: add max size bounds check in input cb
Message-ID: <Zo1GOxXWjmxSBDPv@fedora>
References: <virtio-snd-fuzz-2427-fix-v1-manos.pitsidianakis@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <virtio-snd-fuzz-2427-fix-v1-manos.pitsidianakis@linaro.org>
Received-SPF: pass client-ip=170.10.129.124; envelope-from=mvaralar@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.144,
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

Thanks Manos for sending this,

On Mon, Jul 08, 2024 at 10:09:49AM +0300, Manos Pitsidianakis wrote:
> When reading input audio in the virtio-snd input callback,
> virtio_snd_pcm_in_cb(), we do not check whether the iov can actually fit
> the data buffer. This is because we use the buffer->size field as a
> total-so-far accumulator instead of byte-size-left like in TX buffers.
> 
> This triggers an out of bounds write if the size of the virtio queue
> element is equal to virtio_snd_pcm_status, which makes the available
> space for audio data zero.

Do you mean that the guest driver has set up a request in the rx queue
in which the writable chain of descriptors only contains the status? Is
this correct? Is `available` indicating the available space in the
virtqueue?

Thanks, Matias.


