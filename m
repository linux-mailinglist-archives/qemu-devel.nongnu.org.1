Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id BDFFA8286FC
	for <lists+qemu-devel@lfdr.de>; Tue,  9 Jan 2024 14:23:03 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rNC33-0008JD-H5; Tue, 09 Jan 2024 08:21:41 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1rNC31-0008Ig-EQ
 for qemu-devel@nongnu.org; Tue, 09 Jan 2024 08:21:39 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1rNC2z-0002Nn-Na
 for qemu-devel@nongnu.org; Tue, 09 Jan 2024 08:21:39 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1704806496;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=GTv7VgoEYRymaWy9m17VE8BNd2VzeudXl8qPB2ERN9I=;
 b=MKdP6bc/XFVPM2iT9TnZ9C/7jlWpEWs2wB8IfS+Pv4AMPDnv9Ho8jxkLMo0Rxz2uaR6q2x
 qmrzE1OwJiXs0aqMrpUyYmdJ5xQmMGCx6G7/txl8jcvcppscvEgEofqOgr/o0BNVhmdVK9
 zfveVaryl9gsmOLMV4dIe93EzbkI1WI=
Received: from mail-qt1-f200.google.com (mail-qt1-f200.google.com
 [209.85.160.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-214-R3UH_J7FPpOcQYlBaD6bVw-1; Tue, 09 Jan 2024 08:21:32 -0500
X-MC-Unique: R3UH_J7FPpOcQYlBaD6bVw-1
Received: by mail-qt1-f200.google.com with SMTP id
 d75a77b69052e-4297363e66bso51607901cf.1
 for <qemu-devel@nongnu.org>; Tue, 09 Jan 2024 05:21:32 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1704806492; x=1705411292;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=GTv7VgoEYRymaWy9m17VE8BNd2VzeudXl8qPB2ERN9I=;
 b=N93CBNaJ/5Pz6joMdH2g2EY5HH+77KBkTg3/GnELKkcS14a1wNaS2SAD1Bl50WYvVJ
 IGXhkQj3hLav/Ss3pMIHsrQfsp/a46bVWP4OnjTa0M103HGPqYau3KhXuBLdcCN62sn4
 J9hWXqqF86FZkhklEHmsTCEVrXgxWSEUHV9kKT6wP1i5ZCZYw3fyWgcI/rHo0jhGqta9
 UfR0cHeNvqsffpbvNjc1FVY23UapCxRs31GdvGuTuZ+ZPcVxn5R3pVeUgs/p9ngy45vn
 36JBwBqKiQN5NBgm8mHSY82Crh01ZDHMtoR3ECHd8KwLpU+0hGO2BqhKzrQPxYys6YWR
 U5iQ==
X-Gm-Message-State: AOJu0Yy7NENAR6EGe4adrw/wX/RpmqglMNdh+uGy3iXD/liirbdAPnDa
 QVrUBcbWeHzqB1Ki5sntOnj5I4rgpAMIoPjNoqBJ0cD+l55NsYUhqZ1BLqJDes63e2HLCuZ5LMJ
 4TGvuH82+7GbW1dp/666eWVQ=
X-Received: by 2002:a05:622a:54a:b0:41c:ad7f:5720 with SMTP id
 m10-20020a05622a054a00b0041cad7f5720mr7935378qtx.61.1704806492555; 
 Tue, 09 Jan 2024 05:21:32 -0800 (PST)
X-Google-Smtp-Source: AGHT+IETFC2x5pzPMjwLJKNGqnSOji6kFG4fQJUhpX6+oql4Ytql7fLP8cFi/c9qxSibsuV48TlCYg==
X-Received: by 2002:a05:622a:54a:b0:41c:ad7f:5720 with SMTP id
 m10-20020a05622a054a00b0041cad7f5720mr7935372qtx.61.1704806492317; 
 Tue, 09 Jan 2024 05:21:32 -0800 (PST)
Received: from ?IPV6:2a01:e0a:280:24f0:9db0:474c:ff43:9f5c?
 ([2a01:e0a:280:24f0:9db0:474c:ff43:9f5c])
 by smtp.gmail.com with ESMTPSA id
 bb3-20020a05622a1b0300b004281c19b277sm841321qtb.67.2024.01.09.05.21.30
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 09 Jan 2024 05:21:31 -0800 (PST)
Message-ID: <1644d352-7ced-4ddc-90a8-8190fe863e87@redhat.com>
Date: Tue, 9 Jan 2024 14:21:26 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 00/10] docs/migration: Reorganize migration documentations
Content-Language: en-US
To: Peter Xu <peterx@redhat.com>, qemu-devel@nongnu.org
Cc: "Michael S . Tsirkin" <mst@redhat.com>,
 Alex Williamson <alex.williamson@redhat.com>,
 Jason Wang <jasowang@redhat.com>, Bandan Das <bdas@redhat.com>,
 Prasad Pandit <ppandit@redhat.com>, Fabiano Rosas <farosas@suse.de>
References: <20240109064628.595453-1-peterx@redhat.com> <ZZ0kpnT741chs1np@x1n>
From: =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@redhat.com>
In-Reply-To: <ZZ0kpnT741chs1np@x1n>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=170.10.133.124; envelope-from=clg@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -30
X-Spam_score: -3.1
X-Spam_bar: ---
X-Spam_report: (-3.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-2.493,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_SORBS_WEB=1.5, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
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


> A few things I'd like to mention alongside, because it's documentation
> relevant too, and I'd like to collect if there's any comment.
> 
> I just mostly rewrote two wiki pages completely:
> 
>    https://wiki.qemu.org/ToDo/LiveMigration
>    https://wiki.qemu.org/Features/Migration>
> I merged all the TODO items from Features/Migration into the ToDo page,
> while kept the 2nd page mostly clean, just to route to other places.
> 
> I had a plan to make:
> 
>    https://qemu.org/docs/master
> 
> The solo place for migration documentations (aka, QEMU repo the source of
> truth for migration docs, as it's peroidically built there), making all the
> rest places pointing to that, as I already did in the wiki page.  While I
> kept all the TODOs on the wiki page (not Features/Migration, but
> ToDo/LiveMigration).> 
> Fabiano / anyone: feel free to add / update / correct any entries there
> where applicable.  Also if there's any thoughts on above feel free to let
> me know too.

The Wiki has some limited value, the changelog for instance, but the rest
is a bag of orphan and obsolete pages doomed to bit-rot since it is slowly
being replaced by the in-tree documentation.

The info in the Features/Migration page is redundant with what we have
in-tree, a part from the CREDITS. The TODO list could be some file under :

	https://qemu.org/docs/master/devel/migration

It would be easier to find and it would keep the Wiki to a strict minimum.

Cheers,

C.



