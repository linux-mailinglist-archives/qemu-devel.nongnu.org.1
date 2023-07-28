Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 7DF7D766CC7
	for <lists+qemu-devel@lfdr.de>; Fri, 28 Jul 2023 14:13:57 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qPKsu-0000TK-1O; Fri, 28 Jul 2023 06:39:48 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1qPKsr-0000TC-De
 for qemu-devel@nongnu.org; Fri, 28 Jul 2023 06:39:45 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1qPKsp-0001pB-Hq
 for qemu-devel@nongnu.org; Fri, 28 Jul 2023 06:39:45 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1690540781;
 h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=X+LgdIuqK6mjoT5di8bOGRfhh6NVmJ2/fP5ilDmNSDA=;
 b=EInfshJPgzvsSoZjKcnbwSZFYRbpq+j5YvleneOha1GBUKbgksjhQpL3uP9KLokhUbq6bE
 ly6og0I87ppdSq4A2Ng6y4tsC3+MvktwJR0+jrm5Np9RdkzJ2HJBYZxjztcAm2iN+60K8/
 HECaipbCSdDB30dM5RKTHdaGCPun6Vc=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-649-WHUOBJfCNeWkSve2RbEzHQ-1; Fri, 28 Jul 2023 06:39:38 -0400
X-MC-Unique: WHUOBJfCNeWkSve2RbEzHQ-1
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.rdu2.redhat.com
 [10.11.54.4])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id DA54E86F122;
 Fri, 28 Jul 2023 10:39:36 +0000 (UTC)
Received: from redhat.com (unknown [10.42.28.55])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 32F542017F3E;
 Fri, 28 Jul 2023 10:39:29 +0000 (UTC)
Date: Fri, 28 Jul 2023 11:39:24 +0100
From: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
To: Thomas Huth <thuth@redhat.com>
Cc: =?utf-8?Q?Marc-Andr=C3=A9?= Lureau <marcandre.lureau@redhat.com>,
 qemu-devel@nongnu.org, Beraldo Leal <bleal@redhat.com>,
 Wainer dos Santos Moschetta <wainersm@redhat.com>,
 Yonggang Luo <luoyonggang@gmail.com>,
 Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Alex =?utf-8?Q?Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Bin Meng <bin.meng@windriver.com>
Subject: Re: [PATCH] gitlab: remove duplication between msys jobs
Message-ID: <ZMOa3DIC+5SKxDTI@redhat.com>
References: <20230726161942.229093-1-berrange@redhat.com>
 <0d0f9f65-2ead-6852-20c2-a83e256eecac@redhat.com>
 <ZMJJS5lUtPKpld0q@redhat.com>
 <a56c06a0-a6b4-cee6-be97-3586a836f4d3@redhat.com>
 <ZMODTyTzJrKiDPo5@redhat.com>
 <CAMxuvawrEUmrftcAtsD0=QXHckqTKQRTFqePR7KOJruSoFUxCA@mail.gmail.com>
 <e197a97f-1647-6335-79a7-fd13a66595d6@redhat.com>
 <a0adefbd-041b-c33b-3149-a478bae0fe0e@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <a0adefbd-041b-c33b-3149-a478bae0fe0e@redhat.com>
User-Agent: Mutt/2.2.9 (2022-11-12)
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.4
Received-SPF: pass client-ip=170.10.129.124; envelope-from=berrange@redhat.com;
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

On Fri, Jul 28, 2023 at 12:01:29PM +0200, Thomas Huth wrote:
> On 28/07/2023 11.50, Thomas Huth wrote:
> > On 28/07/2023 11.32, Marc-André Lureau wrote:
> > > Hi
> > > 
> > > On Fri, Jul 28, 2023 at 12:59 PM Daniel P. Berrangé
> > > <berrange@redhat.com> wrote:
> > > > 
> > > > On Fri, Jul 28, 2023 at 10:35:35AM +0200, Thomas Huth wrote:
> > > > > On 27/07/2023 12.39, Daniel P. Berrangé wrote:
> > > > > > On Wed, Jul 26, 2023 at 08:21:33PM +0200, Thomas Huth wrote:
> > > > > > > On 26/07/2023 18.19, Daniel P. Berrangé wrote:
> > > > > ...
> > > > > > > Anyway, before we unify the compiler package name suffix between the two
> > > > > > > jobs, I really would like to see whether the mingw
> > > > > > > Clang builds QEMU faster
> > > > > > > in the 64-bit job ... but so far I failed to convince meson to accept the
> > > > > > > Clang from the mingw package ... does anybody know how to use Clang with
> > > > > > > MSYS2 properly?
> > > > > > 
> > > > > > AFAIK it shouldn't be anything worse than
> > > > > > 
> > > > > >     CC=clang ./configure ....
> > > > > > 
> > > > > > if that doesn't work then its a bug IMHO
> > > > > 
> > > > > No, it's not that easy ... As Marc-André explained to me, MSYS2 maintains a
> > > > > completely separate environment for Clang, i.e. you have to select this
> > > > > different environment with $env:MSYSTEM = 'CLANG64' and then install the
> > > > > packages that have the "mingw-w64-clang-x86_64-" prefix.
> > > > > 
> > > > > After lots of trial and error, I was able to get a test build here:
> > > > > 
> > > > >   https://gitlab.com/thuth/qemu/-/jobs/4758605925
> > > > > 
> > > > > I had to disable Spice and use --disable-werror in that build to make it
> > > > > succeed, but at least it shows that Clang seems to be a little bit faster -
> > > > > the job finished in 58 minutes. So if we can get the warnings fixed, this
> > > > > might be a solution for the timeouts here...
> > > > 
> > > > Those packing warnings look pretty serious
> > > > 
> > > > C:/GitLab-Runner/builds/thuth/qemu/include/block/nvme.h:1781:16:
> > > > warning: unknown attribute 'gcc_struct' ignored
> > > > [-Wunknown-attributes]
> > > > 
> > > > This means CLang is using the MSVC struct packing ABI for bitfields,
> > > > which is different from the GCC struct packing ABI. If any of those
> > > > structs use bitfields and are exposed as guest hardware ABI, or in
> > > > migration vmstate, then this is potentially broken compilation.
> > > > 
> > > 
> > > Yes .. gcc >=4.7 and clang >=12 have mms-bitfiles enabled by default,
> > > but we can't undo that MS struct packing on clang apparently:
> > > https://discourse.llvm.org/t/how-to-undo-the-effect-of-mms-bitfields/72271
> > 
> > I wonder whether we really still need the gcc_struct in QEMU...
> > As far as I understand, this was mainly required for bitfields in packed
> > structs in the past
> 
> Ok, never mind, according to this post:
> 
> https://lists.gnu.org/archive/html/qemu-devel/2011-08/msg00964.html
> 
> this affects all structs, not only the ones with bitfieds.
> 
> And it seems like we also still have packed structs with bitfields in code
> base, see e.g. "struct ip" in net/util.h, so using Clang on Windows likely
> currently can't work?

Just because it has bitfields doesn't mean it will definitely be
different. 

I'm not sure if it is an entirely accurate comparison, but I modified the
native linux build to use 'gcc_struct' and again to use 'ms_struct'. Then
fed all the .o files to 'pahole', and compared the output. There was only
a single difference:

 union VTD_IR_TableEntry {
        struct {
                uint32_t           present:1;          /*     0: 0  4 */
                uint32_t           fault_disable:1;    /*     0: 1  4 */
                uint32_t           dest_mode:1;        /*     0: 2  4 */
                uint32_t           redir_hint:1;       /*     0: 3  4 */
                uint32_t           trigger_mode:1;     /*     0: 4  4 */
                uint32_t           delivery_mode:3;    /*     0: 5  4 */
                uint32_t           __avail:4;          /*     0: 8  4 */
                uint32_t           __reserved_0:3;     /*     0:12  4 */
                uint32_t           irte_mode:1;        /*     0:15  4 */
                uint32_t           vector:8;           /*     0:16  4 */
                uint32_t           __reserved_1:8;     /*     0:24  4 */
                uint32_t           dest_id;            /*     4     4 */
                uint16_t           source_id;          /*     8     2 */
 
                /* Bitfield combined with previous fields */
 
                uint64_t           sid_q:2;            /*     8:16  8 */
                uint64_t           sid_vtype:2;        /*     8:18  8 */
                uint64_t           __reserved_2:44;    /*     8:20  8 */
-       } irte;                                        /*     0    18 */
+       } irte;                                        /*     0    16 */
        uint64_t                   data[2];            /*     0    16 */
 };


from the intel_iommu.c file.

IOW, ms_struct added a 2 byte padding after the uint16_t source_id
field despite 'packed' attribute, but gcc_struct collapsed the
uint16_t  into the uint64_t bitfield since only 48 bits were consumed.

IIUC, this could be made portable by changing

                uint16_t           source_id;          /*     8     2 */

to
                uint64_t           source_id:16;          /*     8     2 */


NB, this was a --target-list=x86_64-softmmu build only, so hasn't
covered the hole codebase. Still shows the gcc_struct annotation
might not be as critical as we imagined.

NB a limitation of the pahole analysis is that it only reports structs that
are actually declared as variabls somewhere - either stack allocated or
heap allocate is fine, as long as there's a declarion of usage somewhre.

With regards,
Daniel
-- 
|: https://berrange.com      -o-    https://www.flickr.com/photos/dberrange :|
|: https://libvirt.org         -o-            https://fstop138.berrange.com :|
|: https://entangle-photo.org    -o-    https://www.instagram.com/dberrange :|


