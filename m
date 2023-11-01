Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id E90227DE491
	for <lists+qemu-devel@lfdr.de>; Wed,  1 Nov 2023 17:27:15 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qyE2t-00068w-VR; Wed, 01 Nov 2023 12:26:20 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eblake@redhat.com>) id 1qyE2s-00067s-5Z
 for qemu-devel@nongnu.org; Wed, 01 Nov 2023 12:26:18 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eblake@redhat.com>) id 1qyE2q-0004u0-16
 for qemu-devel@nongnu.org; Wed, 01 Nov 2023 12:26:17 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1698855973;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=cNeXAznQxI6QyeLLhG1+vkLTHuYD8FwJwAQ6zdhejy4=;
 b=A+BKEpf1fLgJOSshv9ALKw3IsRpxDjG2iIkAKqIiQleTqNUMULVlcWBvREuFOsDUKHc1r3
 Eo4QaHAadU+rTzdjZRR1nkAD3WUj3i2FA+teOfq7cEVySfmccyNGWgyHn1iPltGTAFfVAC
 rxiJDrBmW2d68y9sh57vSaEzMupz+9k=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-96-mXcIBtYeO46eqnQzfpr4EA-1; Wed, 01 Nov 2023 12:26:09 -0400
X-MC-Unique: mXcIBtYeO46eqnQzfpr4EA-1
Received: from smtp.corp.redhat.com (int-mx09.intmail.prod.int.rdu2.redhat.com
 [10.11.54.9])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id D9790185A781;
 Wed,  1 Nov 2023 16:26:08 +0000 (UTC)
Received: from redhat.com (unknown [10.2.16.59])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id AE248492BE0;
 Wed,  1 Nov 2023 16:26:07 +0000 (UTC)
Date: Wed, 1 Nov 2023 11:26:06 -0500
From: Eric Blake <eblake@redhat.com>
To: Hanna Czenczek <hreitz@redhat.com>
Cc: "Denis V. Lunev" <den@virtuozzo.com>, 
 Mike Maslenkin <mike.maslenkin@gmail.com>, qemu-devel@nongnu.org,
 qemu-block@nongnu.org, kwolf@redhat.com, den@openvz.org
Subject: Re: [PATCH v2 1/1] qemu-img: do not erase destination file in
 qemu-img dd command
Message-ID: <ftgqxlzwmrzc7y7c4mk4cy4cjnr3xzz5nwp4siso57wr4hau7w@hq6osdgqcymg>
References: <20230930203157.85766-1-mike.maslenkin@gmail.com>
 <15609bb5-95d0-3d38-4c44-bcd313dc723b@virtuozzo.com>
 <CAL77WPAHSG-B3J_G8JzJHS5OhjsnsDs_wjYyGyPcBbeyS0z8=A@mail.gmail.com>
 <d29be9a0-3765-10b1-24f1-6aa053e4213f@virtuozzo.com>
 <5f3a8585-18ed-4e05-ac6b-ac21178dfe79@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <5f3a8585-18ed-4e05-ac6b-ac21178dfe79@redhat.com>
User-Agent: NeoMutt/20231023
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.9
Received-SPF: pass client-ip=170.10.133.124; envelope-from=eblake@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -24
X-Spam_score: -2.5
X-Spam_bar: --
X-Spam_report: (-2.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.393,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

On Tue, Oct 31, 2023 at 03:33:52PM +0100, Hanna Czenczek wrote:
> Personally, and honestly, I see no actual use for qemu-img dd at all,
> because we’re trying to mimic a subset of an interface of a rather complex
> program that has been designed to do what it does. We can only fail at
> that.  Personally, whenever I need dd functionality, I use
> qemu-storage-daemon’s fuse export, and then use the actual dd program on
> top.  Alternatively, qemu-img convert is our native interface;
> unfortunately, its feature set is lacking when compared to qemu-img dd, but
> I think it would be better to improve that rather than working on qemu-img
> dd.

I also agree that 'qemu-img dd' is not where we should focus; we have
a two-way feature gap (dd can do things convert can't, and convert can
do things dd can't), where the IDEAL world would be convert can do
everything and then dd is then a thin wrapper that calls into convert
under the hood.  Otherwise, we will forever be chasing bugs between
two similar but divergent implementations, and the one that gets more
testing (convert) will be the only one that gets timely fixes.

I should have objected much harder when 'qemu-img dd' was first
proposed.  Oh well.

Here's at least one prior discussion on the mailing list, in 2016(!),
where we proposed enhancing qemu-img dd to add at least seek=; but the
patch was never accepted.  I know there are other bugs lurking in dd
(being unable to choose different offsets for the input and output
file, via skip= vs. seek=, makes it hard to use compared to regular
dd); which backs up my claim that qemu-img dd is low priority.

https://lists.gnu.org/archive/html/qemu-devel/2016-08/msg03896.html

And to some extent, with some convoluted JSON or --image-opts (I
recommend trying it with qemu-storage-daemon, rather than directly in
qemu-img), you CAN open subsets of any other image by layering a raw
BDS with offset/size clamps on top of anything else.  It's just that
we don't have many written examples stating how to do that, although
we DO have such an example in the qemu-nbd documentation:

| Start a long-running server listening with encryption on port 10810,
| and allow clients with a specific X.509 certificate to connect to
| a 1 megabyte subset of a raw file, using the export name 'subset':
| 
| ::
| 
|   qemu-nbd \
|     --object tls-creds-x509,id=tls0,endpoint=server,dir=/path/to/qemutls \
|     --object 'authz-simple,id=auth0,identity=CN=laptop.example.com,,\
|               O=Example Org,,L=London,,ST=London,,C=GB' \
|     --tls-creds tls0 --tls-authz auth0 \
|     -t -x subset -p 10810 \
|     --image-opts driver=raw,offset=1M,size=1M,file.driver=file,file.filename=file.raw

> 
> Summary: If we do this under a new conv=notrunc, fine with me.  I just don’t
> think qemu-img dd is something that should be used at all.

I'm not even sure it is worth adding anything to qemu-img dd.  At this
point, that would just be increasing its technical debt; we're better
off putting lipstick on a pig.

-- 
Eric Blake, Principal Software Engineer
Red Hat, Inc.
Virtualization:  qemu.org | libguestfs.org


