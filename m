Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 961897BD938
	for <lists+qemu-devel@lfdr.de>; Mon,  9 Oct 2023 13:06:25 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qpo5Q-0004f9-4v; Mon, 09 Oct 2023 07:06:09 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1qpo5G-0004TP-US
 for qemu-devel@nongnu.org; Mon, 09 Oct 2023 07:06:02 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1qpo5E-0004B3-UC
 for qemu-devel@nongnu.org; Mon, 09 Oct 2023 07:05:58 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1696849555;
 h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=fKQvoBSggeAo9XJT7o6oL1AWxeIj3PaIF5ao9fRX0ak=;
 b=OtP3OmEj9FXwSVEht6Nq2b9ejiexi4MbuKA40nH4asQ7r7vJlPtO70mMfm+9gtYBDQAEfp
 ziG1VlXKK14w9SPSgKTNqBMJQ2UKxVrBvuVzPbUu+x0p63WtO3h3dOJmXwaz2ZgIEUXBUb
 k9Ev7pTciruO7453jLcqV3oZD1Gq+9A=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-178-eD3LVn9NNL2bKfjRm5mnEQ-1; Mon, 09 Oct 2023 07:05:42 -0400
X-MC-Unique: eD3LVn9NNL2bKfjRm5mnEQ-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.rdu2.redhat.com
 [10.11.54.5])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 00C3681B13F;
 Mon,  9 Oct 2023 11:05:41 +0000 (UTC)
Received: from redhat.com (unknown [10.42.28.42])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id B7640170E9;
 Mon,  9 Oct 2023 11:05:39 +0000 (UTC)
Date: Mon, 9 Oct 2023 12:05:37 +0100
From: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
To: Thomas Huth <thuth@redhat.com>
Cc: qemu-devel@nongnu.org, Paolo Bonzini <pbonzini@redhat.com>,
 =?utf-8?Q?Marc-Andr=C3=A9?= Lureau <marcandre.lureau@redhat.com>,
 Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: Re: [PATCH 2/2] meson: mitigate against use of uninitialize stack
 for exploits
Message-ID: <ZSPegSoz1cvgUcof@redhat.com>
References: <20231005173812.966264-1-berrange@redhat.com>
 <20231005173812.966264-3-berrange@redhat.com>
 <c28a1d44-8e7e-a351-8efa-28566e9fc306@redhat.com>
 <e49485e5-c75a-27f1-7ad3-899b1c208077@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <e49485e5-c75a-27f1-7ad3-899b1c208077@redhat.com>
User-Agent: Mutt/2.2.9 (2022-11-12)
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.5
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

On Mon, Oct 09, 2023 at 12:15:17PM +0200, Thomas Huth wrote:
> On 09/10/2023 09.44, Thomas Huth wrote:
> > On 05/10/2023 19.38, Daniel P. Berrangé wrote:
> > > When variables are used without being initialized, there is potential
> > > to take advantage of data that was pre-existing on the stack from an
> > > earlier call, to drive an exploit.
> > > 
> > > It is good practice to always initialize variables, and the compiler
> > > can warn about flaws when -Wuninitialized is present. This warning,
> > > however, is by no means foolproof with its output varying depending
> > > on compiler version and which optimizations are enabled.
> > > 
> > > The -ftrivial-auto-var-init option can be used to tell the compiler
> > > to always initialize all variables. This increases the security and
> > > predictability of the program, closing off certain attack vectors,
> > > reducing the risk of unsafe memory disclosure.
> > > 
> > > While the option takes several possible values, using 'zero' is
> > > considered to be the  option that is likely to lead to semantically
> > > correct or safe behaviour[1]. eg sizes/indexes are not likely to
> > > lead to out-of-bounds accesses when initialized to zero. Pointers
> > > are less likely to point something useful if initialized to zero.
> > > 
> > > Even with -ftrivial-auto-var-init=zero set, GCC will still issue
> ...
> > > +    '-ftrivial-var-auto-init=zero',
> > >   ]
> 
> There is something fishy here: In the commit description, you write about
> "-ftrivial-auto-var-init" but in the code you use "-ftrivial-var-auto-init"
> ... that looks wrong to me, please fix!

Face palm, -ftrivial-auto-var-init is the correct one.

> > I was a little bit torn about using =zero when I first read your patch,
> > but after looking at [1], I tend now also tend to agree that =zero is
> > likely the best choice.
> 
> Thinking about this twice: What about using -ftrivial-var-auto-init=pattern
> for --enable-debug builds, and only use the "zero" init for non-debug
> builds? ... that would prevent that people blindly rely on this "language
> extension".

We can't blindly rely on it, because -Wuninitialized is still going to
do static analysis and warn in most cases, which can't be ignored when
-Werror is set.

With regards,
Daniel
-- 
|: https://berrange.com      -o-    https://www.flickr.com/photos/dberrange :|
|: https://libvirt.org         -o-            https://fstop138.berrange.com :|
|: https://entangle-photo.org    -o-    https://www.instagram.com/dberrange :|


