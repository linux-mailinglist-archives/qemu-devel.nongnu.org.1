Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id D3AA39752A9
	for <lists+qemu-devel@lfdr.de>; Wed, 11 Sep 2024 14:40:37 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1soMbP-0004R9-IL; Wed, 11 Sep 2024 08:37:43 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eblake@redhat.com>) id 1soMbM-0004Bk-60
 for qemu-devel@nongnu.org; Wed, 11 Sep 2024 08:37:40 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eblake@redhat.com>) id 1soMbI-0001c3-Gb
 for qemu-devel@nongnu.org; Wed, 11 Sep 2024 08:37:39 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1726058255;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=2yyoUHl0RktlwtpBgJrkB7WrBtx0gjcCkcB5aXQqSHw=;
 b=EiRMEf7GzRTVD4iiHNueLZ29Eq2R+odQR6EXVqAXz/0Egc6S8gVioap1iRtTzl6MRbqB1f
 C+J+RTiyZOwy4uK537djNoNN9kMPf1/r+MdE0WttyK/tCEVjk5tybsdc+CFHwXBEQc+pnv
 PFnw5dtPXBWHdMHCMk7ptsjHEoExthw=
Received: from mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-441-jaSzpHeWNrut-meJROLWwg-1; Wed,
 11 Sep 2024 08:37:32 -0400
X-MC-Unique: jaSzpHeWNrut-meJROLWwg-1
Received: from mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.17])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id C874D19560BE; Wed, 11 Sep 2024 12:37:23 +0000 (UTC)
Received: from redhat.com (unknown [10.2.16.98])
 by mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 5E27C19560A3; Wed, 11 Sep 2024 12:37:05 +0000 (UTC)
Date: Wed, 11 Sep 2024 07:37:02 -0500
From: Eric Blake <eblake@redhat.com>
To: Pierrick Bouvier <pierrick.bouvier@linaro.org>
Cc: qemu-devel@nongnu.org, Zhao Liu <zhao1.liu@intel.com>, 
 "Richard W.M. Jones" <rjones@redhat.com>, Joel Stanley <joel@jms.id.au>,
 Kevin Wolf <kwolf@redhat.com>, 
 Paolo Bonzini <pbonzini@redhat.com>, qemu-arm@nongnu.org,
 Corey Minyard <minyard@acm.org>, 
 Eric Farman <farman@linux.ibm.com>, Thomas Huth <thuth@redhat.com>,
 Keith Busch <kbusch@kernel.org>, 
 WANG Xuerui <git@xen0n.name>, Hyman Huang <yong.huang@smartx.com>, 
 Stefan Berger <stefanb@linux.vnet.ibm.com>, Michael Rolnik <mrolnik@gmail.com>,
 Alistair Francis <alistair.francis@wdc.com>,
 =?utf-8?Q?Marc-Andr=C3=A9?= Lureau <marcandre.lureau@redhat.com>, 
 Markus Armbruster <armbru@redhat.com>,
 Sriram Yagnaraman <sriram.yagnaraman@ericsson.com>, 
 Palmer Dabbelt <palmer@dabbelt.com>, qemu-riscv@nongnu.org,
 Ani Sinha <anisinha@redhat.com>, 
 Halil Pasic <pasic@linux.ibm.com>, Jesper Devantier <foss@defmacro.it>, 
 Laurent Vivier <laurent@vivier.eu>, Peter Maydell <peter.maydell@linaro.org>, 
 Igor Mammedov <imammedo@redhat.com>, kvm@vger.kernel.org, 
 Alex =?utf-8?Q?Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Richard Henderson <richard.henderson@linaro.org>, 
 Fam Zheng <fam@euphon.net>, qemu-s390x@nongnu.org,
 Hanna Reitz <hreitz@redhat.com>, 
 Nicholas Piggin <npiggin@gmail.com>, Eduardo Habkost <eduardo@habkost.net>, 
 Laurent Vivier <lvivier@redhat.com>, Rob Herring <robh@kernel.org>, 
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>, qemu-block@nongnu.org, 
 "Maciej S. Szmigiero" <maciej.szmigiero@oracle.com>, qemu-ppc@nongnu.org, 
 Daniel Henrique Barboza <danielhb413@gmail.com>,
 Christian Borntraeger <borntraeger@linux.ibm.com>, 
 Harsh Prateek Bora <harshpb@linux.ibm.com>,
 Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <philmd@linaro.org>, 
 Nina Schoetterl-Glausch <nsg@linux.ibm.com>,
 "Michael S. Tsirkin" <mst@redhat.com>, 
 Fabiano Rosas <farosas@suse.de>, Helge Deller <deller@gmx.de>, 
 Dmitry Fleytman <dmitry.fleytman@gmail.com>,
 Daniel Henrique Barboza <dbarboza@ventanamicro.com>, 
 Akihiko Odaki <akihiko.odaki@daynix.com>, Marcelo Tosatti <mtosatti@redhat.com>,
 David Gibson <david@gibson.dropbear.id.au>,
 Aurelien Jarno <aurelien@aurel32.net>, 
 Liu Zhiwei <zhiwei_liu@linux.alibaba.com>, Yanan Wang <wangyanan55@huawei.com>,
 Peter Xu <peterx@redhat.com>, Bin Meng <bmeng.cn@gmail.com>,
 Weiwei Li <liwei1518@gmail.com>, 
 Klaus Jensen <its@irrelevant.dk>, Jean-Christophe Dubois <jcd@tribudubois.net>,
 Jason Wang <jasowang@redhat.com>
Subject: Re: [PATCH 01/39] docs/spin: replace assert(0) with
 g_assert_not_reached()
Message-ID: <bwo43ms2wi6vbeqhlc7qjwmw5jyt2btxvpph3lqn7tfol4srjf@77yusngzs6wh>
References: <20240910221606.1817478-1-pierrick.bouvier@linaro.org>
 <20240910221606.1817478-2-pierrick.bouvier@linaro.org>
 <zkyoryho5alnyirnl7ulvh5y6tkty6koccgeygmve42uml7glu@37rkdodtlx4f>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <zkyoryho5alnyirnl7ulvh5y6tkty6koccgeygmve42uml7glu@37rkdodtlx4f>
User-Agent: NeoMutt/20240425
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.17
Received-SPF: pass client-ip=170.10.129.124; envelope-from=eblake@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.144,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

On Wed, Sep 11, 2024 at 07:33:59AM GMT, Eric Blake wrote:
> On Tue, Sep 10, 2024 at 03:15:28PM GMT, Pierrick Bouvier wrote:
> > Signed-off-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>
> > ---
> 
> A general suggestion for the entire series: please use a commit
> message that explains why this is a good idea.  Even something as
> boiler-plate as "refer to commit XXX for rationale" that can be
> copy-pasted into all the other commits is better than nothing,
> although a self-contained message is best.  Maybe:
> 
> This patch is part of a series that moves towards a consistent use of
> g_assert_not_reached() rather than an ad hoc mix of different
> assertion mechanisms.

Or summarize your cover letter:

Use of assert(false) can trip spurious control flow warnings from some
versions of gcc:
https://lore.kernel.org/qemu-devel/54bb02a6-1b12-460a-97f6-3f478ef766c6@linaro.org/
Solve that by unifying the code base on g_assert_not_reached()
instead.

-- 
Eric Blake, Principal Software Engineer
Red Hat, Inc.
Virtualization:  qemu.org | libguestfs.org


