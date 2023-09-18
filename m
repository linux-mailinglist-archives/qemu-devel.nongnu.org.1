Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 8E75E7A512E
	for <lists+qemu-devel@lfdr.de>; Mon, 18 Sep 2023 19:45:10 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qiIHe-0006Xx-R8; Mon, 18 Sep 2023 13:43:42 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1qiIHc-0006Vs-Mh
 for qemu-devel@nongnu.org; Mon, 18 Sep 2023 13:43:40 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1qiIHa-0007OW-Mq
 for qemu-devel@nongnu.org; Mon, 18 Sep 2023 13:43:40 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1695059017;
 h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=fvmHyEcDh7HWxNF4TjADeM2NA9dv7A10KEKhSIbat4c=;
 b=BDxES2T7wSJ61zV6jPp/CyM+Mrw50eTi10jyu/jT79Et/ssh+p8188k5+3mtoTLvWL1pNP
 hrSLVesb6bDZQKi//uqNyBx6NNdpULuynUz/WvHk3WYVfxWcobnMcS+fNyiZZJvAPI4uJM
 VO4iLJgiXdWzF5qfMdHiC68szGI+pL8=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-298-Hy0rMP4dOx-2jfW3uGVDqw-1; Mon, 18 Sep 2023 13:43:34 -0400
X-MC-Unique: Hy0rMP4dOx-2jfW3uGVDqw-1
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.rdu2.redhat.com
 [10.11.54.8])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 13223800883;
 Mon, 18 Sep 2023 17:43:34 +0000 (UTC)
Received: from redhat.com (unknown [10.42.28.114])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id EA80DC15BB8;
 Mon, 18 Sep 2023 17:43:32 +0000 (UTC)
Date: Mon, 18 Sep 2023 18:43:30 +0100
From: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
To: Stephen Brennan <stephen.s.brennan@oracle.com>
Cc: qemu-devel@nongnu.org, linux-debuggers@vger.kernel.org,
 =?utf-8?Q?Marc-Andr=C3=A9?= Lureau <marcandre.lureau@gmail.com>,
 Omar Sandoval <osandov@osandov.com>, Thomas Huth <thuth@redhat.com>
Subject: Re: [PATCH v2 qemu 3/3] dump: Add qmp argument "reassembled"
Message-ID: <ZQiMQioTYYWQ13Yh@redhat.com>
References: <20230914010315.945705-1-stephen.s.brennan@oracle.com>
 <20230914010315.945705-4-stephen.s.brennan@oracle.com>
 <ZQg9qjdMZL4Tt6EN@redhat.com> <87msxjxu55.fsf@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <87msxjxu55.fsf@oracle.com>
User-Agent: Mutt/2.2.9 (2022-11-12)
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.8
Received-SPF: pass client-ip=170.10.133.124; envelope-from=berrange@redhat.com;
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
Reply-To: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
Errors-To: qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org
Sender: qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org

On Mon, Sep 18, 2023 at 10:34:30AM -0700, Stephen Brennan wrote:
> Daniel P. Berrangé <berrange@redhat.com> writes:
> > #
> > # @DumpGuestMemoryFormat:
> > #
> > # An enumeration of guest-memory-dump's format.
> > #
> > # @elf: elf format
> > #
> > # @kdump-zlib: makedumpfile flattened, kdump-compressed format with zlib-compressed
> > #
> > # @kdump-lzo: makedumpfile flattened, kdump-compressed format with lzo-compressed
> > #
> > # @kdump-snappy: makedumpfile flattened, kdump-compressed format with snappy-compressed
> > #
> > # @kdump-raw-zlib: raw assembled kdump-compressed format with zlib-compressed (since 8.2)
> > #
> > # @kdump-raw-lzo: raw assembled kdump-compressed format with lzo-compressed (since 8.2)
> > #
> > # @kdump-raw-snappy: raw assembled kdump-compressed format with snappy-compressed (since 8.2)
> > #
> > # @win-dmp: Windows full crashdump format, can be used instead of ELF
> > #     converting (since 2.13)
> > #
> > # Since: 2.0
> > ##
> > { 'enum': 'DumpGuestMemoryFormat',
> >   'data': [ 'elf',
> >             'kdump-zlib', 'kdump-lzo', 'kdump-snappy',
> >             'kdump-raw-zlib', 'kdump-raw-lzo', 'kdump-raw-snappy',
> >             'win-dmp' ] }
> 
> Hi Daniel,
> 
> Sure, I'll go ahead and use this approach instead. One question: I see
> that this generates the enumeration DumpGuestMemoryFormat in
> qapi-types-dump.h. I just wanted to double-check if there's any ABI
> considerations for the numbering of this enum? Inserting kdump-raw-* at
> this point would result in 'win-dmp' getting a different numbering, and
> it seems possible that the API/ABI which libvirt uses might depend on
> the enumeration values not changing. E.G. if libvirt is built against
> one version of Qemu and then used with a different one.

The QAPI integer representation of enums is a private internal impl
detail known only to QEMU.

In terms of QMP, the on the wire representation is exclusively string
format, so safe wrt re-ordering for new/old QEMU and new/old libvirt.


In livirt's own public API, if we chose to expose these new formats,
then we have to strictly append after the existing enums constants
in libvirt's header file.

With regards,
Daniel
-- 
|: https://berrange.com      -o-    https://www.flickr.com/photos/dberrange :|
|: https://libvirt.org         -o-            https://fstop138.berrange.com :|
|: https://entangle-photo.org    -o-    https://www.instagram.com/dberrange :|


