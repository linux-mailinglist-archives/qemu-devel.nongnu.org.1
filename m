Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 8BA6E8D209E
	for <lists+qemu-devel@lfdr.de>; Tue, 28 May 2024 17:41:51 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sByx2-0001SE-4W; Tue, 28 May 2024 11:41:24 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kwolf@redhat.com>) id 1sByx0-0001Pg-6v
 for qemu-devel@nongnu.org; Tue, 28 May 2024 11:41:22 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kwolf@redhat.com>) id 1sBywx-00050G-Gv
 for qemu-devel@nongnu.org; Tue, 28 May 2024 11:41:21 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1716910878;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=kyGi9UdW+xpLxXoH2Pl3Iy/zCK6fAJL8srGJ8UkYlg0=;
 b=gf0rkX5gVwI+3Aame7pVcRHHiX8VsPJT8fZlZBgEun11Q5B75f3s2l9h4P0zvZQf9INaAt
 NpSZOq6bXbU0shuzFANsXwz/5hn6Q85DGm5O/G8uBsu0zEEry/SWirZ9zEFHwLxd1Rn9yi
 oF/0EDjenJAKx0cyw5X8Y3wVLKScfBM=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-133-enO9PoyvMoCUMKEtaYrZvQ-1; Tue, 28 May 2024 11:41:13 -0400
X-MC-Unique: enO9PoyvMoCUMKEtaYrZvQ-1
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.rdu2.redhat.com
 [10.11.54.4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id CFFF381227E;
 Tue, 28 May 2024 15:41:12 +0000 (UTC)
Received: from redhat.com (unknown [10.39.195.1])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id AADD32026D68;
 Tue, 28 May 2024 15:41:09 +0000 (UTC)
Date: Tue, 28 May 2024 17:41:08 +0200
From: Kevin Wolf <kwolf@redhat.com>
To: Daniel =?iso-8859-1?Q?P=2E_Berrang=E9?= <berrange@redhat.com>
Cc: qemu-devel@nongnu.org, Thomas Huth <thuth@redhat.com>,
 Alex =?iso-8859-1?Q?Benn=E9e?= <alex.bennee@linaro.org>,
 "Michael S. Tsirkin" <mst@redhat.com>, Gerd Hoffmann <kraxel@redhat.com>,
 Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>,
 Philippe =?iso-8859-1?Q?Mathieu-Daud=E9?= <philmd@linaro.org>,
 Stefan Hajnoczi <stefanha@redhat.com>, Alexander Graf <agraf@csgraf.de>,
 Paolo Bonzini <pbonzini@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Peter Maydell <peter.maydell@linaro.org>,
 Markus Armbruster <armbru@redhat.com>
Subject: Re: [PATCH v2 2/3] docs: define policy limiting the inclusion of
 generated files
Message-ID: <ZlX7FEt015hEfzG_@redhat.com>
References: <20240516162230.937047-1-berrange@redhat.com>
 <20240516162230.937047-3-berrange@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20240516162230.937047-3-berrange@redhat.com>
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.4
Received-SPF: pass client-ip=170.10.129.124; envelope-from=kwolf@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.034,
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
Errors-To: qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org
Sender: qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org

Am 16.05.2024 um 18:22 hat Daniel P. Berrang� geschrieben:
> Files contributed to QEMU are generally expected to be provided in the
> preferred format for manipulation. IOW, we generally don't expect to
> have generated / compiled code included in the tree, rather, we expect
> to run the code generator / compiler as part of the build process.
> 
> There are some obvious exceptions to this seen in our existing tree, the
> biggest one being the inclusion of many binary firmware ROMs. A more
> niche example is the inclusion of a generated eBPF program. Or the CI
> dockerfiles which are mostly auto-generated. In these cases, however,
> the preferred format source code is still required to be included,
> alongside the generated output.
> 
> Tools which perform user defined algorithmic transformations on code are
> not considered to be "code generators". ie, we permit use of coccinelle,
> spell checkers, and sed/awk/etc to manipulate code. Such use of automated
> manipulation should still be declared in the commit message.
> 
> One off generators which create a boilerplate file which the author then
> fills in, are acceptable if their output has clear copyright and license
> status. This could be where a contributor writes a throwaway python
> script to automate creation of some mundane piece of code for example.
> 
> Signed-off-by: Daniel P. Berrang� <berrange@redhat.com>
> ---
>  docs/devel/code-provenance.rst | 55 ++++++++++++++++++++++++++++++++++
>  1 file changed, 55 insertions(+)
> 
> diff --git a/docs/devel/code-provenance.rst b/docs/devel/code-provenance.rst
> index 7c42fae571..eabb3e7c08 100644
> --- a/docs/devel/code-provenance.rst
> +++ b/docs/devel/code-provenance.rst
> @@ -210,3 +210,58 @@ mailing list.
>  It is also recommended to attempt to contact the original author to let them
>  know you are interested in taking over their work, in case they still intended
>  to return to the work, or had any suggestions about the best way to continue.
> +
> +Inclusion of generated files
> +~~~~~~~~~~~~~~~~~~~~~~~~~~~~
> +
> +Files in patches contributed to QEMU are generally expected to be provided
> +only in the preferred format for making modifications. The implication of
> +this is that the output of code generators or compilers is usually not
> +appropriate to contribute to QEMU.
> +
> +For reasons of practicality there are some exceptions to this rule, where
> +generated code is permitted, provided it is also accompanied by the
> +corresponding preferred source format. This is done where it is impractical
> +to expect those building QEMU to run the code generation or compilation
> +process. A non-exhustive list of examples is:
> +
> + * Images: where an bitmap image is created from a vector file it is common
> +   to include the rendered bitmaps at desired resolution(s), since subtle
> +   changes in the rasterization process / tools may affect quality. The
> +   original vector file is expected to accompany any generated bitmaps.
> +
> + * Firmware: QEMU includes pre-compiled binary ROMs for a variety of guest
> +   firmwares. When such binary ROMs are contributed, the corresponding source
> +   must also be provided, either directly, or through a git submodule link.
> +
> + * Dockerfiles: the majority of the dockerfiles are automatically generated
> +   from a canonical list of build dependencies maintained in tree, together
> +   with the libvirt-ci git submodule link. The generated dockerfiles are
> +   included in tree because it is desirable to be able to directly build
> +   container images from a clean git checkout.
> +
> + * EBPF: QEMU includes some generated EBPF machine code, since the required
> +   eBPF compilation tools are not broadly available on all targetted OS
> +   distributions. The corresponding eBPF C code for the binary is also
> +   provided. This is a time limited exception until the eBPF toolchain is
> +   sufficiently broadly available in distros.

This paragraph is inconsistent with the spelling of "EBPF"/"eBPF".

Kevin


