Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 15FAF7B07F3
	for <lists+qemu-devel@lfdr.de>; Wed, 27 Sep 2023 17:17:37 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qlWHF-0002oq-T7; Wed, 27 Sep 2023 11:16:37 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1qlWHE-0002mR-5N
 for qemu-devel@nongnu.org; Wed, 27 Sep 2023 11:16:36 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1qlWHA-0007Yt-RD
 for qemu-devel@nongnu.org; Wed, 27 Sep 2023 11:16:35 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1695827791;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=M0YQHcbZhq4efjWXZZzqIM/AdrkLqowtnSIvAj2D8dg=;
 b=WlRtEtNBDXFUJ9A2FIKmZ1/gl74nNvYGnppz+2ZkmbZO2QWvloDIosZU2DF0eacbrC5bi1
 pziUdW+lkqXuLZkKdrS5qEAOJnvx7cFSK+ma3X0xpR6SvjFnN9Z5mSrZaaVNZXQVjcxVK3
 z2KSindXfPXqliAvSqsvKoOKtL0elwY=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-689-kT6uIwxONBm8l6pod6jogQ-1; Wed, 27 Sep 2023 11:16:28 -0400
X-MC-Unique: kT6uIwxONBm8l6pod6jogQ-1
Received: by mail-wr1-f70.google.com with SMTP id
 ffacd0b85a97d-31f3cfe7269so8773707f8f.2
 for <qemu-devel@nongnu.org>; Wed, 27 Sep 2023 08:16:28 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1695827787; x=1696432587;
 h=in-reply-to:content-transfer-encoding:content-disposition
 :mime-version:references:message-id:subject:cc:to:from:date
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=M0YQHcbZhq4efjWXZZzqIM/AdrkLqowtnSIvAj2D8dg=;
 b=pWMGtkpCV/s8xD/mBVMT1jZ6UmZp965ReMVJvFkpLHqzXxbeO4PxWuwaZSJ8vQAISS
 x+yP+8QjWv8JmK6T/1l19tfdzzTBV3nDRJAcmeggVCP4i5heLA/XhJSVATWMdn8sPLc9
 n/HNDjbmV96TyxRN9hdxd557DQw/U9PxJeOnQ0br0vPu1p5GVIz1bTGWLfzfUBH5uzj2
 KBGPnJk3Q/iMU0GKtS9/trEnglC0QvciiRGXpJpTka5Qzc6viEYPMoreYfGATCRiYzZK
 7rNdyf5FBzBkCdk0QJRpQVAbmX+kTQN/c0cyU7hWM4fM41PEpeNi2DsH+up5RfBMw2aT
 TFqg==
X-Gm-Message-State: AOJu0YyICMvM1/3SF2hD9pM2CDYMrG0U41/bPmZA2oCyJyUlYeFvboab
 zCqeQFtvL2t0JoYQr4e0md9T3VpHeHsMgdyFBe5zsWaK0/+pcJfeNOy8U7xpEjXwBzTX1hpQY8V
 5lCQLGVgdmliPR5k=
X-Received: by 2002:adf:e791:0:b0:31f:fdcf:b2b6 with SMTP id
 n17-20020adfe791000000b0031ffdcfb2b6mr2107144wrm.55.1695827787550; 
 Wed, 27 Sep 2023 08:16:27 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IH/uVhjaf3t49uRXk6kJx2FaVi8BMOI499scPncgYqjWyIthOHFcp1DhPyo5COcVCj9bmXSyA==
X-Received: by 2002:adf:e791:0:b0:31f:fdcf:b2b6 with SMTP id
 n17-20020adfe791000000b0031ffdcfb2b6mr2107118wrm.55.1695827787192; 
 Wed, 27 Sep 2023 08:16:27 -0700 (PDT)
Received: from redhat.com ([2a02:14f:16e:b9f6:556e:c001:fe18:7e0a])
 by smtp.gmail.com with ESMTPSA id
 x6-20020a5d60c6000000b0031f300a4c26sm17267390wrt.93.2023.09.27.08.16.23
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 27 Sep 2023 08:16:26 -0700 (PDT)
Date: Wed, 27 Sep 2023 11:16:20 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Daniel =?iso-8859-1?Q?P=2E_Berrang=E9?= <berrange@redhat.com>
Cc: Salil Mehta <salil.mehta@huawei.com>, xianglai li <lixianglai@loongson.cn>,
 "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>,
 Bernhard Beschow <shentey@gmail.com>, Salil Mehta <salil.mehta@opnsrc.net>,
 Xiaojuan Yang <yangxiaojuan@loongson.cn>,
 Song Gao <gaosong@loongson.cn>, Igor Mammedov <imammedo@redhat.com>,
 Ani Sinha <anisinha@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Eduardo Habkost <eduardo@habkost.net>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 Philippe =?iso-8859-1?Q?Mathieu-Daud=E9?= <philmd@linaro.org>,
 "wangyanan (Y)" <wangyanan55@huawei.com>,
 Peter Xu <peterx@redhat.com>, David Hildenbrand <david@redhat.com>,
 Bibo Mao <maobibo@loongson.cn>
Subject: Re: [PATCH v3 2/7] Update CPUs AML with cpu-(ctrl)dev change
Message-ID: <20230927111523-mutt-send-email-mst@kernel.org>
References: <cover.1695697701.git.lixianglai@loongson.cn>
 <c2ab409710f5e0f0346727b47aaabd14537d45b8.1695697701.git.lixianglai@loongson.cn>
 <17a09b8ab65542be8561cb0480dae6bd@huawei.com>
 <20230926071055-mutt-send-email-mst@kernel.org>
 <4cc68780b63f47879d757fe604f37892@huawei.com>
 <20230926074945-mutt-send-email-mst@kernel.org>
 <ZRLO5m0K3ilV9VUt@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <ZRLO5m0K3ilV9VUt@redhat.com>
Received-SPF: pass client-ip=170.10.129.124; envelope-from=mst@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

On Tue, Sep 26, 2023 at 01:30:30PM +0100, Daniel P. Berrangé wrote:
> On Tue, Sep 26, 2023 at 07:54:04AM -0400, Michael S. Tsirkin wrote:
> > On Tue, Sep 26, 2023 at 11:45:19AM +0000, Salil Mehta wrote:
> > > 
> > > > From: Michael S. Tsirkin <mst@redhat.com>
> > > > Sent: Tuesday, September 26, 2023 12:12 PM
> > > > To: Salil Mehta <salil.mehta@huawei.com>
> > > > Cc: xianglai li <lixianglai@loongson.cn>; qemu-devel@nongnu.org; Bernhard
> > > > Beschow <shentey@gmail.com>; Salil Mehta <salil.mehta@opnsrc.net>; Xiaojuan
> > > > Yang <yangxiaojuan@loongson.cn>; Song Gao <gaosong@loongson.cn>; Igor
> > > > Mammedov <imammedo@redhat.com>; Ani Sinha <anisinha@redhat.com>; Paolo
> > > > Bonzini <pbonzini@redhat.com>; Richard Henderson
> > > > <richard.henderson@linaro.org>; Eduardo Habkost <eduardo@habkost.net>;
> > > > Marcel Apfelbaum <marcel.apfelbaum@gmail.com>; Philippe Mathieu-Daudé
> > > > <philmd@linaro.org>; wangyanan (Y) <wangyanan55@huawei.com>; Daniel P.
> > > > Berrangé <berrange@redhat.com>; Peter Xu <peterx@redhat.com>; David
> > > > Hildenbrand <david@redhat.com>; Bibo Mao <maobibo@loongson.cn>
> > > > Subject: Re: [PATCH v3 2/7] Update CPUs AML with cpu-(ctrl)dev change
> > > > 
> > > > On Tue, Sep 26, 2023 at 10:49:08AM +0000, Salil Mehta wrote:
> > > > > Hi Xianglai,
> > > > > FYI. RFC V2 is out and you can now drop the arch agnostic patches from
> > > > > your patch-set. Please check the details in the cover letter which one
> > > > > you need to pick and rebase from:
> > > > >
> > > > > https://lore.kernel.org/qemu-devel/20230926100436.28284-1-
> > > > salil.mehta@huawei.com/T/#t
> > > > >
> > > > > I am planning to float the architecture agnostic patch-set within this
> > > > > week which will have same patches and in same order as mentioned in
> > > > > the cover letter. This will untie the development across different
> > > > > architectures.
> > > > >
> > > > > Many thanks
> > > > > Salil.
> > > > 
> > > > However, please get authorship info right. This claims patch has been
> > > > codeveloped by Bernhard Beschow, xianglai li and yourself.
> > > > Your patch claims a completely different list of authors
> > > 
> > > Yes, because those are the people who have developed the patches.
> > > 
> > > > with yourself being the only common author.
> > > > Not nice.
> > > 
> > > I have already replied in the other thread. This patch has been
> > > taken from the ARM patch-set sent in the year 2020.
> > > 
> > > I am not sure who is the other author and how he has contributed.
> > > 
> > > Co-developed-by usually points at main authors.
> > > 
> > 
> > 
> > If you are not sure then find out please.
> > And to help you stop guessing at the rules:
> > 
> > Documentation/process/submitting-patches.rst
> > 
> > 	Co-developed-by: states that the patch was co-created by multiple developers;
> > 	it is used to give attribution to co-authors (in addition to the author
> > 	attributed by the From: tag) when several people work on a single patch.  Since
> > 	Co-developed-by: denotes authorship, every Co-developed-by: must be immediately
> > 	followed by a Signed-off-by: of the associated co-author.  Standard sign-off
> > 	procedure applies, i.e. the ordering of Signed-off-by: tags should reflect the
> > 	chronological history of the patch insofar as possible, regardless of whether
> > 	the author is attributed via From: or Co-developed-by:.  Notably, the last
> > 	Signed-off-by: must always be that of the developer submitting the patch.
> 
> Note, that's a linux.git docs requirement you're pointing to,
> not a QEMU one.
> 
> I don't think QEMU has historically gone about this level
> of precise detail/strictness.
> 
> Nothing in the DCO requires every co-developer to add a S-o-B.
> The person adding a S-o-B is attesting that they are confident
> they have the rights to submit this. One way they can attain
> this confidence is if the people they worked with add their own
> S-o-B but that's not a hard requirement. *If* some co-developers
> were working inside the same company and copyright is owned by
> the company, it is reasonable to only have one S-o-B for the
> person who finally submits it. That's a judgement call the person
> submitting can make.
> 
> With regards,
> Daniel

We really should write the rules up btw.
And, I think it would be a really bad idea to use exactly
the same tag as linux with a slightly different set of rules.



> -- 
> |: https://berrange.com      -o-    https://www.flickr.com/photos/dberrange :|
> |: https://libvirt.org         -o-            https://fstop138.berrange.com :|
> |: https://entangle-photo.org    -o-    https://www.instagram.com/dberrange :|


