Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 8F1057AECE3
	for <lists+qemu-devel@lfdr.de>; Tue, 26 Sep 2023 14:31:39 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1ql7DY-0008JZ-2F; Tue, 26 Sep 2023 08:31:08 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1ql7D9-0008Dx-GA
 for qemu-devel@nongnu.org; Tue, 26 Sep 2023 08:30:45 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1ql7D7-0005rs-Bs
 for qemu-devel@nongnu.org; Tue, 26 Sep 2023 08:30:43 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1695731439;
 h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=61VLE0YTLBIoA7hHKAUzCNc1QAOqfJZmtJR5pI5aHek=;
 b=XTYcBeSCBXcmGXWxQNDZnf46QGIu66ZQt9uVa2yXsYZxoT5j/v9DbKifyZMfam2Ubm2LmC
 P+oIE6LfCALjmMNqr0m8rDnw9tdhFlihkLOvybRj/yndE2/q0Fw8+/q/+5kJUfflhwijd/
 5Z8VMYo8UYfj63wuVn0/IR1Ah8iIwYo=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-216-Ti86dApQO6urkydqZLWc1w-1; Tue, 26 Sep 2023 08:30:35 -0400
X-MC-Unique: Ti86dApQO6urkydqZLWc1w-1
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.rdu2.redhat.com
 [10.11.54.6])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 707DD8007A4;
 Tue, 26 Sep 2023 12:30:34 +0000 (UTC)
Received: from redhat.com (unknown [10.42.28.75])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 1C0F72156A27;
 Tue, 26 Sep 2023 12:30:31 +0000 (UTC)
Date: Tue, 26 Sep 2023 13:30:30 +0100
From: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
To: "Michael S. Tsirkin" <mst@redhat.com>
Cc: Salil Mehta <salil.mehta@huawei.com>, xianglai li <lixianglai@loongson.cn>,
 "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>,
 Bernhard Beschow <shentey@gmail.com>, Salil Mehta <salil.mehta@opnsrc.net>,
 Xiaojuan Yang <yangxiaojuan@loongson.cn>,
 Song Gao <gaosong@loongson.cn>, Igor Mammedov <imammedo@redhat.com>,
 Ani Sinha <anisinha@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Eduardo Habkost <eduardo@habkost.net>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 "wangyanan (Y)" <wangyanan55@huawei.com>,
 Peter Xu <peterx@redhat.com>, David Hildenbrand <david@redhat.com>,
 Bibo Mao <maobibo@loongson.cn>
Subject: Re: [PATCH v3 2/7] Update CPUs AML with cpu-(ctrl)dev change
Message-ID: <ZRLO5m0K3ilV9VUt@redhat.com>
References: <cover.1695697701.git.lixianglai@loongson.cn>
 <c2ab409710f5e0f0346727b47aaabd14537d45b8.1695697701.git.lixianglai@loongson.cn>
 <17a09b8ab65542be8561cb0480dae6bd@huawei.com>
 <20230926071055-mutt-send-email-mst@kernel.org>
 <4cc68780b63f47879d757fe604f37892@huawei.com>
 <20230926074945-mutt-send-email-mst@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20230926074945-mutt-send-email-mst@kernel.org>
User-Agent: Mutt/2.2.9 (2022-11-12)
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.6
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

On Tue, Sep 26, 2023 at 07:54:04AM -0400, Michael S. Tsirkin wrote:
> On Tue, Sep 26, 2023 at 11:45:19AM +0000, Salil Mehta wrote:
> > 
> > > From: Michael S. Tsirkin <mst@redhat.com>
> > > Sent: Tuesday, September 26, 2023 12:12 PM
> > > To: Salil Mehta <salil.mehta@huawei.com>
> > > Cc: xianglai li <lixianglai@loongson.cn>; qemu-devel@nongnu.org; Bernhard
> > > Beschow <shentey@gmail.com>; Salil Mehta <salil.mehta@opnsrc.net>; Xiaojuan
> > > Yang <yangxiaojuan@loongson.cn>; Song Gao <gaosong@loongson.cn>; Igor
> > > Mammedov <imammedo@redhat.com>; Ani Sinha <anisinha@redhat.com>; Paolo
> > > Bonzini <pbonzini@redhat.com>; Richard Henderson
> > > <richard.henderson@linaro.org>; Eduardo Habkost <eduardo@habkost.net>;
> > > Marcel Apfelbaum <marcel.apfelbaum@gmail.com>; Philippe Mathieu-Daudé
> > > <philmd@linaro.org>; wangyanan (Y) <wangyanan55@huawei.com>; Daniel P.
> > > Berrangé <berrange@redhat.com>; Peter Xu <peterx@redhat.com>; David
> > > Hildenbrand <david@redhat.com>; Bibo Mao <maobibo@loongson.cn>
> > > Subject: Re: [PATCH v3 2/7] Update CPUs AML with cpu-(ctrl)dev change
> > > 
> > > On Tue, Sep 26, 2023 at 10:49:08AM +0000, Salil Mehta wrote:
> > > > Hi Xianglai,
> > > > FYI. RFC V2 is out and you can now drop the arch agnostic patches from
> > > > your patch-set. Please check the details in the cover letter which one
> > > > you need to pick and rebase from:
> > > >
> > > > https://lore.kernel.org/qemu-devel/20230926100436.28284-1-
> > > salil.mehta@huawei.com/T/#t
> > > >
> > > > I am planning to float the architecture agnostic patch-set within this
> > > > week which will have same patches and in same order as mentioned in
> > > > the cover letter. This will untie the development across different
> > > > architectures.
> > > >
> > > > Many thanks
> > > > Salil.
> > > 
> > > However, please get authorship info right. This claims patch has been
> > > codeveloped by Bernhard Beschow, xianglai li and yourself.
> > > Your patch claims a completely different list of authors
> > 
> > Yes, because those are the people who have developed the patches.
> > 
> > > with yourself being the only common author.
> > > Not nice.
> > 
> > I have already replied in the other thread. This patch has been
> > taken from the ARM patch-set sent in the year 2020.
> > 
> > I am not sure who is the other author and how he has contributed.
> > 
> > Co-developed-by usually points at main authors.
> > 
> 
> 
> If you are not sure then find out please.
> And to help you stop guessing at the rules:
> 
> Documentation/process/submitting-patches.rst
> 
> 	Co-developed-by: states that the patch was co-created by multiple developers;
> 	it is used to give attribution to co-authors (in addition to the author
> 	attributed by the From: tag) when several people work on a single patch.  Since
> 	Co-developed-by: denotes authorship, every Co-developed-by: must be immediately
> 	followed by a Signed-off-by: of the associated co-author.  Standard sign-off
> 	procedure applies, i.e. the ordering of Signed-off-by: tags should reflect the
> 	chronological history of the patch insofar as possible, regardless of whether
> 	the author is attributed via From: or Co-developed-by:.  Notably, the last
> 	Signed-off-by: must always be that of the developer submitting the patch.

Note, that's a linux.git docs requirement you're pointing to,
not a QEMU one.

I don't think QEMU has historically gone about this level
of precise detail/strictness.

Nothing in the DCO requires every co-developer to add a S-o-B.
The person adding a S-o-B is attesting that they are confident
they have the rights to submit this. One way they can attain
this confidence is if the people they worked with add their own
S-o-B but that's not a hard requirement. *If* some co-developers
were working inside the same company and copyright is owned by
the company, it is reasonable to only have one S-o-B for the
person who finally submits it. That's a judgement call the person
submitting can make.

With regards,
Daniel
-- 
|: https://berrange.com      -o-    https://www.flickr.com/photos/dberrange :|
|: https://libvirt.org         -o-            https://fstop138.berrange.com :|
|: https://entangle-photo.org    -o-    https://www.instagram.com/dberrange :|


