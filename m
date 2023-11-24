Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 445337F72F0
	for <lists+qemu-devel@lfdr.de>; Fri, 24 Nov 2023 12:42:01 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1r6UZ9-0005Yu-It; Fri, 24 Nov 2023 06:41:47 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1r6UZ5-0005YE-Qr
 for qemu-devel@nongnu.org; Fri, 24 Nov 2023 06:41:43 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1r6UYq-00013C-Gq
 for qemu-devel@nongnu.org; Fri, 24 Nov 2023 06:41:43 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1700826087;
 h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=wSbmGEf4fPvrvpHLPAqfnGkgDVNeeyvr1d/iduuNx3Q=;
 b=iLE/q9WBshwHnJugDebklg4wINkRMZpp1wlUtXobJ3wm2ojqW6yPoBiGZDEteHVGkhafxF
 aea/Xvab3w91KnsJFPF8h1+tYT1aqTc8gQCLQLRTdQAzadGGpoKPMBEX+jlj/FT2x6kqp6
 7gFzO224OD1zDI+vZb7Lw035HpSbOvE=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-683-Qto2_0hqMKSizQcqa042ZA-1; Fri, 24 Nov 2023 06:41:25 -0500
X-MC-Unique: Qto2_0hqMKSizQcqa042ZA-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.rdu2.redhat.com
 [10.11.54.2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 6F6508007B3;
 Fri, 24 Nov 2023 11:41:25 +0000 (UTC)
Received: from redhat.com (unknown [10.42.28.110])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id CFCDD40C6EB9;
 Fri, 24 Nov 2023 11:41:22 +0000 (UTC)
Date: Fri, 24 Nov 2023 11:41:20 +0000
From: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
To: Alex =?utf-8?Q?Benn=C3=A9e?= <alex.bennee@linaro.org>
Cc: "Michael S. Tsirkin" <mst@redhat.com>, qemu-devel@nongnu.org,
 Richard Henderson <richard.henderson@linaro.org>,
 Alexander Graf <agraf@csgraf.de>, Paolo Bonzini <pbonzini@redhat.com>,
 Markus Armbruster <armbru@redhat.com>,
 Phil =?utf-8?Q?Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Stefan Hajnoczi <stefanha@redhat.com>,
 Thomas Huth <thuth@redhat.com>, Kevin Wolf <kwolf@redhat.com>,
 Gerd Hoffmann <kraxel@redhat.com>,
 Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>,
 Peter Maydell <peter.maydell@linaro.org>
Subject: Re: [PATCH 2/2] docs: define policy forbidding use of "AI" / LLM
 code generators
Message-ID: <ZWCL4C0wwH2cygRz@redhat.com>
References: <20231123114026.3589272-1-berrange@redhat.com>
 <20231123114026.3589272-3-berrange@redhat.com>
 <20231123092523-mutt-send-email-mst@kernel.org>
 <ZV-S1f2cK8MLNizz@redhat.com>
 <20231123172828-mutt-send-email-mst@kernel.org>
 <ZWBngLoa3ERuMxGJ@redhat.com> <87plzzcuzm.fsf@draig.linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <87plzzcuzm.fsf@draig.linaro.org>
User-Agent: Mutt/2.2.10 (2023-03-25)
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.2
Received-SPF: pass client-ip=170.10.129.124; envelope-from=berrange@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.058,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 SPF_HELO_NONE=0.001, T_SCC_BODY_TEXT_LINE=-0.01,
 T_SPF_TEMPERROR=0.01 autolearn=ham autolearn_force=no
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

On Fri, Nov 24, 2023 at 10:21:17AM +0000, Alex Bennée wrote:
> Daniel P. Berrangé <berrange@redhat.com> writes:
> 
> > On Thu, Nov 23, 2023 at 05:39:18PM -0500, Michael S. Tsirkin wrote:
> >> On Thu, Nov 23, 2023 at 05:58:45PM +0000, Daniel P. Berrangé wrote:
> >> > The license of a code generation tool itself is usually considered
> >> > to be not a factor in the license of its output.
> >> 
> >> Really? I would find it very surprising if a code generation tool that
> >> is not a language model and so is not understanding the code it's
> >> generating did not include some code snippets going into the output.
> >> It is also possible to unintentionally run afoul of GPL's definition of source
> >> code which is "the preferred form of the work for making modifications to it". 
> >> So even if you have copyright to input, dumping just output and putting
> >> GPL on it might or might not be ok.
> >
> > Consider the C pre-processor. This takes an input .c file, and expands
> > all the macros, to split out a new .c file.
> >
> > The license of the output .c file is determined by the license of the
> > input .c file. The license of the CPP impl (whether OSS or proprietary)
> > doesn't have any influence on the license of the output file, it cannot
> > magically force the output file to be proprietary any more than it can
> > force it to be output file GPL.
> 
> LLM's are just a tool like a compiler (albeit with spookier different
> internals). The prompt and the instructions are arguably the more
> important part of how to get good results from the LLM transformation.
> In fact most of the way I've been using them has been by pasting some
> existing code and asking for review or transformation of it.
> 
> However I totally get that using the various online LLMs you have very
> little transparency about what has gone into their training and therefor
> there is a danger of proprietary code being hallucinated out of their
> matricies. Conversely what if I use an LLM like OpenLLaMa:
> 
>   https://github.com/openlm-research/open_llama
> 
> I have fairly exhaustive definitions of what went into the training data
> which of most interest is probably the StarCoder dataset (paper):
> 
>   https://drive.google.com/file/d/1cN-b9GnWtHzQRoE7M7gAEyivY0kl4BYs/view
> 
> where there are tools to detect if generated code has been lifted
> directly from the dataset or is indeed a transformation.

I've not looked at the links above, but I think if someone can make an
compelling argument that *specific* tools have sufficient transparency
to be compatible with signing the DCO, then I think we could maintain a
list of exceptions in the policy.

With regards,
Daniel
-- 
|: https://berrange.com      -o-    https://www.flickr.com/photos/dberrange :|
|: https://libvirt.org         -o-            https://fstop138.berrange.com :|
|: https://entangle-photo.org    -o-    https://www.instagram.com/dberrange :|


