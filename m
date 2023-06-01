Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 32A817197F0
	for <lists+qemu-devel@lfdr.de>; Thu,  1 Jun 2023 11:58:19 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1q4f3s-0001JJ-4P; Thu, 01 Jun 2023 05:57:40 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1q4f3q-0001Hm-9A
 for qemu-devel@nongnu.org; Thu, 01 Jun 2023 05:57:38 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1q4f3o-0007RJ-E8
 for qemu-devel@nongnu.org; Thu, 01 Jun 2023 05:57:38 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1685613453;
 h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=ZbaqjqA7zBV27kCpyH0V4ALMnsOi9OZ2dLHA2lBhUP4=;
 b=QVkP82gJYSdjsvkGY6wMPN/X4k+b7JdCyISGg/cpUQq04DhMFyyfaLFzeudsoK38G03k+J
 rUoTIWUFR2cr1N7ArdPN2gWpUZKy3Tt1w/ZoU7k/NbWVKB/kavMUlqTgaqplenvfApc0m8
 T3cG7lRYkcnYvcHZeNwvRwdh6mafC4s=
Received: from mimecast-mx02.redhat.com (mx3-rdu2.redhat.com
 [66.187.233.73]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-632-5nU0jifBNgGhVoxb4Gy4kg-1; Thu, 01 Jun 2023 05:57:31 -0400
X-MC-Unique: 5nU0jifBNgGhVoxb4Gy4kg-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.rdu2.redhat.com
 [10.11.54.2])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 9E67A2A59540;
 Thu,  1 Jun 2023 09:57:31 +0000 (UTC)
Received: from redhat.com (unknown [10.42.28.153])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id B706C40C6EC4;
 Thu,  1 Jun 2023 09:57:30 +0000 (UTC)
Date: Thu, 1 Jun 2023 10:57:27 +0100
From: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
To: Erik Skultety <eskultet@redhat.com>
Cc: Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 qemu-devel@nongnu.org
Subject: Re: [PATCH 2/3] tests/vm: Introduce
 get_qemu_packages_from_lcitool_vars() helper
Message-ID: <ZHhrh1tJjvC3xF62@redhat.com>
References: <20230531200906.17790-1-philmd@linaro.org>
 <20230531200906.17790-3-philmd@linaro.org>
 <ZHhKe3fzmau7qsMn@ridgehead.home.lan>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <ZHhKe3fzmau7qsMn@ridgehead.home.lan>
User-Agent: Mutt/2.2.9 (2022-11-12)
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.2
Received-SPF: pass client-ip=170.10.133.124; envelope-from=berrange@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -22
X-Spam_score: -2.3
X-Spam_bar: --
X-Spam_report: (-2.3 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.163,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
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

On Thu, Jun 01, 2023 at 09:36:27AM +0200, Erik Skultety wrote:
> On Wed, May 31, 2023 at 10:09:05PM +0200, Philippe Mathieu-Daudé wrote:
> > The 'lcitool variables $OS qemu' command produces a file containing
> > consistent environment variables helpful to build QEMU on $OS.
> > In particular the $PKGS variable contains the packages required to
> > build QEMU.
> > 
> > Since some of these files are committed in the repository (see
> > 0e103a65ba "gitlab: support for FreeBSD 12, 13 and macOS 11 via
> > cirrus-run"), we can parse these files to get the package list
> > required to build a VM.
> > 
> > Add the get_qemu_packages_from_lcitool_vars() helper which return
> > such package list from a lcitool env var file.
> > 
> > Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
> > ---
> >  tests/vm/basevm.py | 6 ++++++
> >  1 file changed, 6 insertions(+)
> > 
> > diff --git a/tests/vm/basevm.py b/tests/vm/basevm.py
> > index 8ec021ddcf..2632c3d41a 100644
> > --- a/tests/vm/basevm.py
> > +++ b/tests/vm/basevm.py
> > @@ -522,6 +522,12 @@ def get_qemu_version(qemu_path):
> >      version_num = re.split(' |\(', version_line)[3].split('.')[0]
> >      return int(version_num)
> >  
> > +def get_qemu_packages_from_lcitool_vars(vars_path):
> > +    """Parse a lcitool variables file and return the PKGS list."""
> > +    with open(vars_path, 'r') as fd:
> > +        line = list(filter(lambda y: y.startswith('PKGS'), fd.readlines()))[0]
> > +        return line.split("'")[1].split()
> 
> Nothing wrong with this one, it's also less lines of code, but just an FYI in
> case you wanted a slightly more readable (yet a tiny bit less performant piece
> of code) you could make use of the JSON format with 'variables --format json'.

Specifically we could do

   with open(vars_path, 'r') as fh:
     return json.load(fh)['pkgs']


With regards,
Daniel
-- 
|: https://berrange.com      -o-    https://www.flickr.com/photos/dberrange :|
|: https://libvirt.org         -o-            https://fstop138.berrange.com :|
|: https://entangle-photo.org    -o-    https://www.instagram.com/dberrange :|


