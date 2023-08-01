Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 769E176BD53
	for <lists+qemu-devel@lfdr.de>; Tue,  1 Aug 2023 21:08:55 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qQujA-0000LE-NS; Tue, 01 Aug 2023 15:08:19 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1qQuix-0000GS-J8
 for qemu-devel@nongnu.org; Tue, 01 Aug 2023 15:08:04 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1qQuiw-0006Vn-2d
 for qemu-devel@nongnu.org; Tue, 01 Aug 2023 15:08:03 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1690916880;
 h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=IOt1vLdVUgsgVBcEhzJlaErayFQCsdgXvqRpeAJtNCg=;
 b=cVUS/SELEnTWaXOGaIDVqr/BtHvFxjjRz9XJNXZ7UyMmNojWiH8KImIFQAyy6lHCCsGLqF
 T2r38FdDnUcy6ma1sm6A3DLgQdxC4sI9n8aTOySWbvQKTRPqYuER+4+BsHjbxdXG3MnWvI
 mjbRbdUeCPBt31WohBJqjhI5LTYYCeM=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-132-Ph0ssSVvN3WxoXLT3pR5-w-1; Tue, 01 Aug 2023 15:07:56 -0400
X-MC-Unique: Ph0ssSVvN3WxoXLT3pR5-w-1
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.rdu2.redhat.com
 [10.11.54.7])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 1EC55104D516;
 Tue,  1 Aug 2023 19:07:56 +0000 (UTC)
Received: from redhat.com (unknown [10.42.28.93])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 0F5821454145;
 Tue,  1 Aug 2023 19:07:54 +0000 (UTC)
Date: Tue, 1 Aug 2023 20:07:53 +0100
From: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
To: Thomas Huth <thuth@redhat.com>
Cc: qemu-devel@nongnu.org,
 Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Beraldo Leal <bleal@redhat.com>,
 Alex =?utf-8?Q?Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Wainer dos Santos Moschetta <wainersm@redhat.com>,
 Yonggang Luo <luoyonggang@gmail.com>, Paolo Bonzini <pbonzini@redhat.com>
Subject: Re: [PATCH 6/8] configure: support passthrough of -Dxxx args to meson
Message-ID: <ZMlYCUGk1P2sZgEz@redhat.com>
References: <20230801130403.164060-1-berrange@redhat.com>
 <20230801130403.164060-7-berrange@redhat.com>
 <43afccca-6828-8cdb-47a7-2feb548d330d@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <43afccca-6828-8cdb-47a7-2feb548d330d@redhat.com>
User-Agent: Mutt/2.2.9 (2022-11-12)
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.7
Received-SPF: pass client-ip=170.10.133.124; envelope-from=berrange@redhat.com;
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
Reply-To: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
Errors-To: qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org
Sender: qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org

On Tue, Aug 01, 2023 at 08:42:05PM +0200, Thomas Huth wrote:
> On 01/08/2023 15.04, Daniel P. Berrangé wrote:
> > This can be useful for setting some meson global options, such as the
> > optimization level or debug state.xs
> > 
> > Signed-off-by: Daniel P. Berrangé <berrange@redhat.com>
> > ---
> >   configure | 5 +++++
> >   1 file changed, 5 insertions(+)
> > 
> > diff --git a/configure b/configure
> > index 26ec5e4f54..9fe3718b77 100755
> > --- a/configure
> > +++ b/configure
> > @@ -757,6 +757,9 @@ for opt do
> >     # everything else has the same name in configure and meson
> >     --*) meson_option_parse "$opt" "$optarg"
> >     ;;
> > +  # Pass through -Dxxxx options to meson
> > +  -D*) meson_options="$meson_options $opt"
> > +  ;;
> >     esac
> >   done
> > @@ -887,6 +890,8 @@ cat << EOF
> >     pie             Position Independent Executables
> >     debug-tcg       TCG debugging (default is disabled)
> > +  -Dmesonoptname=val      passthrough option to meson unmodified
> 
> I'd rather place that earlier in the help text, above the
> "meson_options_help" line in the configure script, next to the other
> --option=something lines.

Sure I've no preference. I was expecting Paolo to tell me to put it
somewhere else anyway :-)


With regards,
Daniel
-- 
|: https://berrange.com      -o-    https://www.flickr.com/photos/dberrange :|
|: https://libvirt.org         -o-            https://fstop138.berrange.com :|
|: https://entangle-photo.org    -o-    https://www.instagram.com/dberrange :|


