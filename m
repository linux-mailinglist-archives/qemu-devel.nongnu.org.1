Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id EB6B9A49DF2
	for <lists+qemu-devel@lfdr.de>; Fri, 28 Feb 2025 16:47:55 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1to2aZ-0000z9-NN; Fri, 28 Feb 2025 10:47:47 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <anthony@xenproject.org>)
 id 1to2a9-0000la-Iv; Fri, 28 Feb 2025 10:47:28 -0500
Received: from mail.xenproject.org ([104.130.215.37])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <anthony@xenproject.org>)
 id 1to2a6-0005aE-7e; Fri, 28 Feb 2025 10:47:20 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=xenproject.org; s=20200302mail; h=In-Reply-To:Content-Transfer-Encoding:
 Content-Type:MIME-Version:References:Message-ID:Subject:Cc:To:From:Date;
 bh=wYrYPIeLMpXibk0d35LLmBJZ9i6aCN3miwYcK3/IlPk=; b=dV4NVDp+BT30jXxAqv8PE12Hw3
 4q30SXCAvJlWfLG5FwqTPZD+ut0UBkuBbi0qq9zgca+jNk4ME9NiMYfyvyUBid4wsDJ5BrtVszYny
 cqr8t77TP9CFQBC5jCs1l5gHFwumXqziRW/NU7d+U2hYG2diiZuYr0LlUE+rXr1//zLA=;
Received: from xenbits.xenproject.org ([104.239.192.120])
 by mail.xenproject.org with esmtp (Exim 4.96)
 (envelope-from <anthony@xenproject.org>) id 1to2Zp-00AMHm-1O;
 Fri, 28 Feb 2025 15:47:01 +0000
Received: from [2a01:e0a:1da:8420:b77:bd5:6e45:7633] (helo=l14)
 by xenbits.xenproject.org with esmtpsa (TLS1.3) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.96)
 (envelope-from <anthony@xenproject.org>) id 1to2Zo-00FN1V-2C;
 Fri, 28 Feb 2025 15:47:00 +0000
Date: Fri, 28 Feb 2025 16:46:57 +0100
From: Anthony PERARD <anthony@xenproject.org>
To: Philippe =?iso-8859-1?Q?Mathieu-Daud=E9?= <philmd@linaro.org>
Cc: qemu-devel@nongnu.org, Richard Henderson <richard.henderson@linaro.org>,
 xen-devel@lists.xenproject.org, qemu-arm@nongnu.org,
 Stefano Stabellini <sstabellini@kernel.org>, Paul Durrant <paul@xen.org>,
 Andrew Cooper <andrew.cooper3@citrix.com>, Juergen Gross <jgross@suse.com>,
 Daniel =?iso-8859-1?Q?P=2E_Berrang=E9?= <berrange@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>,
 "Edgar E. Iglesias" <edgar.iglesias@gmail.com>,
 =?iso-8859-1?Q?Marc-Andr=E9?= Lureau <marcandre.lureau@redhat.com>,
 Peter Maydell <peter.maydell@linaro.org>,
 Eduardo Habkost <eduardo@habkost.net>,
 "Michael S. Tsirkin" <mst@redhat.com>,
 David Woodhouse <dwmw2@infradead.org>,
 Vikram Garhwal <vikram.garhwal@bytedance.com>,
 Thomas Huth <thuth@redhat.com>, Jan Beulich <jbeulich@suse.com>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>
Subject: Re: [PATCH 5/8] hw/xen/xen-hvm: Reduce included headers
Message-ID: <Z8HacRL-K00TB1ye@l14>
References: <20250218162618.46167-1-philmd@linaro.org>
 <20250218162618.46167-6-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20250218162618.46167-6-philmd@linaro.org>
Received-SPF: pass client-ip=104.130.215.37;
 envelope-from=anthony@xenproject.org; helo=mail.xenproject.org
X-Spam_score_int: -43
X-Spam_score: -4.4
X-Spam_bar: ----
X-Spam_report: (-4.4 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_MED=-2.3, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001, SPF_HELO_PASS=-0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

On Tue, Feb 18, 2025 at 05:26:15PM +0100, Philippe Mathieu-Daudé wrote:
> Have "hw/xen/xen-hvm-common.h" include the bare minimal set
> of headers. Adapt sources to avoid errors when refactoring
> unrelated headers such:
> 
>   include/hw/xen/xen-hvm-common.h:71:5: error: unknown type name ‘xenevtchn_handle’
>      71 |     xenevtchn_handle *xce_handle;
>         |     ^~~~~~~~~~~~~~~~
>   hw/xen/xen-hvm-common.c: In function ‘cpu_get_ioreq’:
>   hw/xen/xen-hvm-common.c:227:13: error: implicit declaration of function ‘hw_error’
>     227 |             hw_error("Fatal error while trying to get io event!\n");
>         |             ^~~~~~~~
>         |             herror
>   hw/xen/xen-hvm-common.c: In function ‘handle_ioreq’:
>   hw/xen/xen-hvm-common.c:446:34: error: ‘target_ulong’ undeclared (first use in this function)
>     446 |             (req->size < sizeof (target_ulong))) {
>         |                                  ^~~~~~~~~~~~
>   hw/i386/xen/xen-hvm.c: In function ‘xen_add_to_physmap’:
>   hw/i386/xen/xen-hvm.c:298:22: error: implicit declaration of function ‘xen_replace_cache_entry’
>     298 |         uint8_t *p = xen_replace_cache_entry(phys_offset, start_addr, size);
>         |                      ^~~~~~~~~~~~~~~~~~~~~~~
>   hw/i386/xen/xen-hvm.c: In function ‘xen_log_global_start’:
>   hw/i386/xen/xen-hvm.c:465:9: error: implicit declaration of function ‘xen_enabled’
>     465 |     if (xen_enabled()) {
>         |         ^~~~~~~~~~~
>   hw/i386/xen/xen-hvm.c: In function ‘regs_to_cpu’:
>   hw/i386/xen/xen-hvm.c:487:5: error: unknown type name ‘X86CPU’
>     487 |     X86CPU *cpu;
>         |     ^~~~~~
>   hw/i386/xen/xen-hvm.c:492:15: error: ‘R_EAX’ undeclared (first use in this function)
>     492 |     env->regs[R_EAX] = req->data;
>         |               ^~~~~
>         |               REG_RAX
> 
> Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>

Reviewed-by: Anthony PERARD <anthony.perard@vates.tech>

Thanks,

-- 
Anthony PERARD

