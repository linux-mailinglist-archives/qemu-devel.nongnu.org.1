Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 2DEB47A4948
	for <lists+qemu-devel@lfdr.de>; Mon, 18 Sep 2023 14:09:58 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qiD3F-0005oR-Po; Mon, 18 Sep 2023 08:08:29 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1qiD3A-0005oE-OW
 for qemu-devel@nongnu.org; Mon, 18 Sep 2023 08:08:25 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1qiD37-0001A3-JL
 for qemu-devel@nongnu.org; Mon, 18 Sep 2023 08:08:24 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1695038899;
 h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:in-reply-to:in-reply-to:  references:references;
 bh=GcjX/yqa0XsH/V2A0bXbw5v8EYCuR0cJVt9GrD+omTw=;
 b=GJGCvDAojvqcKmCUmjrD0PwFFZScnWhgbv2maWk/gluai7K3t3TylANjUm/+ZtfDJ21i5Y
 5AfHz5/36QLsmO65FcezxQZ7wfhl+oMDrU/C8HXMDIKqca1MFEifFvyi9xOPC7if45E1uo
 DjWMI2rUp5wFZrfpmuT+1RjezHDxy6A=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-540-70VGz_asMWK7KFLCNAXW0g-1; Mon, 18 Sep 2023 08:08:14 -0400
X-MC-Unique: 70VGz_asMWK7KFLCNAXW0g-1
Received: from smtp.corp.redhat.com (int-mx10.intmail.prod.int.rdu2.redhat.com
 [10.11.54.10])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id B13DE85A5BD;
 Mon, 18 Sep 2023 12:08:13 +0000 (UTC)
Received: from redhat.com (unknown [10.42.28.114])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id B4AEE492B05;
 Mon, 18 Sep 2023 12:08:12 +0000 (UTC)
Date: Mon, 18 Sep 2023 13:08:10 +0100
From: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
To: Stephen Brennan <stephen.s.brennan@oracle.com>
Cc: qemu-devel@nongnu.org, linux-debuggers@vger.kernel.org,
 =?utf-8?Q?Marc-Andr=C3=A9?= Lureau <marcandre.lureau@gmail.com>,
 Omar Sandoval <osandov@osandov.com>, Thomas Huth <thuth@redhat.com>
Subject: Re: [PATCH v2 qemu 3/3] dump: Add qmp argument "reassembled"
Message-ID: <ZQg9qjdMZL4Tt6EN@redhat.com>
References: <20230914010315.945705-1-stephen.s.brennan@oracle.com>
 <20230914010315.945705-4-stephen.s.brennan@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20230914010315.945705-4-stephen.s.brennan@oracle.com>
User-Agent: Mutt/2.2.9 (2022-11-12)
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.10
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

On Wed, Sep 13, 2023 at 06:03:15PM -0700, Stephen Brennan wrote:
> This can be used from QMP command line as "-R" to mirror the
> corresponding flag for makedumpfile. This enables the kdump_reassembled
> flag introduced in the previous patch.
> 
> Signed-off-by: Stephen Brennan <stephen.s.brennan@oracle.com>
> ---
>  dump/dump-hmp-cmds.c |  8 +++++++-
>  dump/dump.c          | 12 +++++++++++-
>  hmp-commands.hx      |  7 +++++--
>  qapi/dump.json       | 14 +++++++++++++-
>  4 files changed, 36 insertions(+), 5 deletions(-)

> diff --git a/qapi/dump.json b/qapi/dump.json
> index 4ae1f722a9..9cc7c3ea93 100644
> --- a/qapi/dump.json
> +++ b/qapi/dump.json
> @@ -69,6 +69,18 @@
>  #     to dump all guest's memory, please specify the start @begin and
>  #     @length
>  #
> +# @reassembled: if false (the default), the kdump output formats will use the
> +#     "makedumpfile flattened" variant of the format, which is less broadly
> +#     compatible with analysis tools. The flattened dump can be reassembled
> +#     after the fact using the command "makedumpfile -R". If true, Qemu
> +#     attempts to generate the standard kdump format. This requires a
> +#     seekable file as output -- if the output file is not seekable, then
> +#     the flattened format is still generated. The standard format is more
> +#     broadly compatible with debugging tools, but generating it requires a
> +#     seekable output file descriptor, and could use more system memory due
> +#     to page cache utilization. This should be left unspecified for non-kdump
> +#     output formats.
> +#
>  # @format: if specified, the format of guest memory dump.  But non-elf
>  #     format is conflict with paging and filter, ie.  @paging, @begin
>  #     and @length is not allowed to be specified with non-elf @format
> @@ -89,7 +101,7 @@
>  { 'command': 'dump-guest-memory',
>    'data': { 'paging': 'bool', 'protocol': 'str', '*detach': 'bool',
>              '*begin': 'int', '*length': 'int',
> -            '*format': 'DumpGuestMemoryFormat'} }
> +            '*reassembled': 'bool', '*format': 'DumpGuestMemoryFormat'} }

The 'reassembled' flag is changing the meaning of 3 out of the 5
'format' enum values. IMHO, we should just be adding new formats
instead of changing the meaning of existing formats. It is a shame
we have the current 'kdump' naming prefix, but we're stuck with
that for backwards compat, we need a new prefix. I'd suggest
'kdump-raw'. eg

#
# @DumpGuestMemoryFormat:
#
# An enumeration of guest-memory-dump's format.
#
# @elf: elf format
#
# @kdump-zlib: makedumpfile flattened, kdump-compressed format with zlib-compressed
#
# @kdump-lzo: makedumpfile flattened, kdump-compressed format with lzo-compressed
#
# @kdump-snappy: makedumpfile flattened, kdump-compressed format with snappy-compressed
#
# @kdump-raw-zlib: raw assembled kdump-compressed format with zlib-compressed (since 8.2)
#
# @kdump-raw-lzo: raw assembled kdump-compressed format with lzo-compressed (since 8.2)
#
# @kdump-raw-snappy: raw assembled kdump-compressed format with snappy-compressed (since 8.2)
#
# @win-dmp: Windows full crashdump format, can be used instead of ELF
#     converting (since 2.13)
#
# Since: 2.0
##
{ 'enum': 'DumpGuestMemoryFormat',
  'data': [ 'elf',
            'kdump-zlib', 'kdump-lzo', 'kdump-snappy',
            'kdump-raw-zlib', 'kdump-raw-lzo', 'kdump-raw-snappy',
            'win-dmp' ] }


With regards,
Daniel
-- 
|: https://berrange.com      -o-    https://www.flickr.com/photos/dberrange :|
|: https://libvirt.org         -o-            https://fstop138.berrange.com :|
|: https://entangle-photo.org    -o-    https://www.instagram.com/dberrange :|


