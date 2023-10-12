Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 1E7327C76FD
	for <lists+qemu-devel@lfdr.de>; Thu, 12 Oct 2023 21:35:31 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qr1RZ-0001TS-W3; Thu, 12 Oct 2023 15:34:02 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1qr1RW-0001T5-Oq
 for qemu-devel@nongnu.org; Thu, 12 Oct 2023 15:33:58 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1qr1RV-0000TT-0l
 for qemu-devel@nongnu.org; Thu, 12 Oct 2023 15:33:58 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1697139236;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=9/anCOjyh3xaDqyN3zucAC206zLkE6CKnIORPSIFrf4=;
 b=eewVIZ2gFqqlIcgANBi6Ij/EYiv3nFhvkd5NjrS8RjCf3m7b30DGXa8vrw8nwGoAkG+ue8
 SzJ+OHZ5y8LvToz7V0K1AFfiKL0UyEKScFf2emvRn6GF8B8dHRnH6+oR7SPyn7Fm4nJ2Pz
 8ZzyiVSGXgRYNu8XLlxgjDajoogXOao=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-364-nfMMjH9IMyK1I7knTnY8tg-1; Thu, 12 Oct 2023 15:33:54 -0400
X-MC-Unique: nfMMjH9IMyK1I7knTnY8tg-1
Received: by mail-wm1-f70.google.com with SMTP id
 5b1f17b1804b1-4075a573035so12958905e9.1
 for <qemu-devel@nongnu.org>; Thu, 12 Oct 2023 12:33:54 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1697139233; x=1697744033;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=9/anCOjyh3xaDqyN3zucAC206zLkE6CKnIORPSIFrf4=;
 b=fiD2cMMZb6XHhfvtlOxYjWlmbUfl3fpWQHOJZc7tUwKxtUMnhh1iObG8Oy52iBgxWT
 Q1hPH66q/7pQh3toQ3erPuLYalJmzfXkVEsof0D8z2k91MevbcqVnFVTjLLD/+u/Z0Pj
 i5pQcy4TqckvKj1HnqngpCBjrThfwZrf+upQ1hWLpJKQG87UzzgvTiaU1Feb/TbvCX0o
 +2jDkNcs6Gfff5DndYO+OaUsWXWcIN02Vua8puKPpZxnzN1zXQ+uEMjGq8BNEkTwB2zP
 wIQgnFwzPWSJVngkeIn++aJzrUZbtrrGmBB8iTH+GIKhQ3lgWewdWgfyQDCGwypAgbKm
 RhSQ==
X-Gm-Message-State: AOJu0YxBMGzw9ShFKDrcq1PJ150TKxtrc7heBvgBOfAoVWpxtPMrj3jm
 Urt1YZIkLkRPjCOJirt+w/C3KpEY9RpsI7zUAkYkLQpDfNbnLSFVqDV9lkGYxj3fZyYCt40TJoY
 5h3uuD84pqU3XqDc=
X-Received: by 2002:a05:600c:230d:b0:407:5b54:bb13 with SMTP id
 13-20020a05600c230d00b004075b54bb13mr6586194wmo.37.1697139233515; 
 Thu, 12 Oct 2023 12:33:53 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHdwCMgK2JwXOCkyXcWN2SYeHF07xf41Z3I8uYg50UE5kqz/cy5tNQA3Z+zILYzTxNnvVyVBg==
X-Received: by 2002:a05:600c:230d:b0:407:5b54:bb13 with SMTP id
 13-20020a05600c230d00b004075b54bb13mr6586171wmo.37.1697139233130; 
 Thu, 12 Oct 2023 12:33:53 -0700 (PDT)
Received: from redhat.com ([2a06:c701:73d2:bf00:e379:826:5137:6b23])
 by smtp.gmail.com with ESMTPSA id
 q19-20020a1cf313000000b0040596352951sm621358wmq.5.2023.10.12.12.33.51
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 12 Oct 2023 12:33:52 -0700 (PDT)
Date: Thu, 12 Oct 2023 15:33:49 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>
Cc: Alex =?iso-8859-1?Q?Benn=E9e?= <alex.bennee@linaro.org>,
 qemu-devel <qemu-devel@nongnu.org>,
 Qemu-block <qemu-block@nongnu.org>, yc-core@yandex-team.ru,
 Daniil Tatianin <d-tatianin@yandex-team.ru>,
 Denis Plotnikov <den-plotnikov@yandex-team.ru>,
 Kevin Wolf <kwolf@redhat.com>
Subject: Re: vhost-user question about VHOST_USER_F_PROTOCOL_FEATURES
Message-ID: <20231012152854-mutt-send-email-mst@kernel.org>
References: <06ea0a74-f10e-4625-bdf1-0caa805b2af7@yandex-team.ru>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <06ea0a74-f10e-4625-bdf1-0caa805b2af7@yandex-team.ru>
Received-SPF: pass client-ip=170.10.133.124; envelope-from=mst@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

On Thu, Oct 12, 2023 at 09:20:28PM +0300, Vladimir Sementsov-Ogievskiy wrote:
> Hi all!
> 
> We now have a problem in downstream:
> 
> We have a vhost-user server, which doesn't support VHOST_USER_SET_VRING_ENABLE. As I understand, vhost-user specification allows it. So the server behaves as follows:
> 
> 1. in GET_FEATURES, it sets VHOST_USER_F_PROTOCOL_FEATURES, to report support for protocol features.
> 
> 2. if this flag VHOST_USER_F_PROTOCOL_FEATURES is set in SET_FEATURES, it reports an error
> 
> In my opinion, this doesn't violate the specification, maybe I'm wrong.

well it doesn't but it's a quality of implementation issue.
if you set a feature bit in GET_FEATURES you should fully expect clients
to set this bit.

> Newer QEMU, after commits
> 
>     02b61f38d357490 "hw/virtio: incorporate backend features in features"
>     and
>     4daa5054c599c8a
>       "vhost: enable vrings in vhost_dev_start() for vhost-user devices"
> 
> actually doesn't support such behavior, as QEMU assumes that if we have the flag in GET_FEATURES, it is supported by SET_FEATURES.
> 
> 
> I don't see any possibility to clearly support in QEMU both servers which supports vring enable/disable and older servers that doesn't.
> 
> =====
> 
> I also want to clarify,
> 
> 1. is "feature negotiated" means set both in GET_FEATURES and SET_FEATURES, as this term is not directly defined.

generally both but yes, it is unfortunately vague in virtio spec too.

> 2. What VHOST_USER_SET_VRING_ENABLE should do for vhost-user-blk? What meant by "side effects" in this case? All IO requests should just fail, not touching the actual storage?

we discussed this recently upstream.
I think most devices should just not process the ring.
network is one of exceptions where you can harmlessly discard packets and
guest does not care much.


> 3. Except for VHOST_USER_SET_VRING_ENABLE, there is another command require not just VHOST_USER_F_PROTOCOL_FEATURES being present in GET_FEATURES, but "negotiated" i.e., as I understand being then set in SET_OPTIONS by client. That's VHOST_USER_SET_SLAVE_REQ_FD. Why? Is it a mistake?

generally frontend must set a bit before using it.
this way backend knows what is going to be used.


> 4. Also, in VHOST_USER_SET_FEATURES definition:
> 
>          Feature bit ``VHOST_USER_F_PROTOCOL_FEATURES`` signals
>   back-end support for ``VHOST_USER_GET_PROTOCOL_FEATURES`` and
>   ``VHOST_USER_SET_PROTOCOL_FEATURES``.
> 
> 
> That seems wrong, as the flag in SET command is about vring enable/disable related behavior.

I think we meant frontend use not backend support.

> -- 
> Best regards,
> Vladimir


