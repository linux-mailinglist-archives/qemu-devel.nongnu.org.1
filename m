Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 6C97D81ECBC
	for <lists+qemu-devel@lfdr.de>; Wed, 27 Dec 2023 08:01:52 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rINtr-0007Ec-HZ; Wed, 27 Dec 2023 02:00:19 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhao1.liu@intel.com>)
 id 1rINtn-0007EH-Jf
 for qemu-devel@nongnu.org; Wed, 27 Dec 2023 02:00:16 -0500
Received: from mgamail.intel.com ([192.55.52.88])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhao1.liu@intel.com>)
 id 1rINtj-0003WP-7s
 for qemu-devel@nongnu.org; Wed, 27 Dec 2023 02:00:14 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1703660411; x=1735196411;
 h=date:from:to:cc:subject:message-id:references:
 mime-version:content-transfer-encoding:in-reply-to;
 bh=nfSz/u7osEkzjLAf2flG/PQ7EsPwxUn6cJ2tDokiZpo=;
 b=ZIUCTlUhI/Yw0G6mwDOjYFbS2wUjTyTZH6uCAYuZ39IWgnb8DOYWaEg+
 DxoCffAfeRENaMQdVsVvgGTxQ+02oeWVBYT3A8YCrVNehn/hcgNvhIQmr
 Dut163Zj0VAo71c6XNLEQWJ71C4eb/wcrLE/OL421gZfSfLFVTLWTfWrz
 FZyQVNHk5yWhQnat32IWXZ3vKgyEa3HlTsnw4nlVSQpoLHASPHvHgzFBO
 GAADfvGVTcQe3kZs+ZnX1z20OXwvjKfptsTmV6ypJ1U+2NIkYzaTcCP7t
 buCWVPp25MketiEruyZmJk99FwY0CJLyjG53uB9VAseEC0W6yxy15ZDVE Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10935"; a="427587528"
X-IronPort-AV: E=Sophos;i="6.04,308,1695711600"; d="scan'208";a="427587528"
Received: from orsmga004.jf.intel.com ([10.7.209.38])
 by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 26 Dec 2023 22:59:59 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10935"; a="901595167"
X-IronPort-AV: E=Sophos;i="6.04,308,1695711600"; d="scan'208";a="901595167"
Received: from liuzhao-optiplex-7080.sh.intel.com (HELO localhost)
 ([10.239.160.36])
 by orsmga004.jf.intel.com with ESMTP; 26 Dec 2023 22:59:55 -0800
Date: Wed, 27 Dec 2023 15:12:44 +0800
From: Zhao Liu <zhao1.liu@intel.com>
To: Philippe =?iso-8859-1?Q?Mathieu-Daud=E9?= <philmd@linaro.org>
Cc: qemu-devel@nongnu.org, Daniel Henrique Barboza <danielhb413@gmail.com>,
 Peter Maydell <peter.maydell@linaro.org>,
 "Michael S . Tsirkin" <mst@redhat.com>,
 =?iso-8859-1?Q?Marc-Andr=E9?= Lureau <marcandre.lureau@redhat.com>,
 Thomas Huth <thuth@redhat.com>, Anton Johansson <anjo@rev.ng>,
 Michael Tokarev <mjt@tls.msk.ru>,
 Alex =?iso-8859-1?Q?Benn=E9e?= <alex.bennee@linaro.org>,
 Daniel =?iso-8859-1?Q?P=2E_Berrang=E9?= <berrange@redhat.com>,
 Juan Quintela <quintela@redhat.com>, David Hildenbrand <david@redhat.com>,
 Markus Armbruster <armbru@redhat.com>,
 Stefan Hajnoczi <stefanha@redhat.com>, Zhao Liu <zhao1.liu@intel.com>
Subject: Re: [PATCH] docs/devel: Document conventional file prefixes and
 suffixes
Message-ID: <ZYvObNOY0ThdpyYi@intel.com>
References: <20231226150441.97501-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20231226150441.97501-1-philmd@linaro.org>
Received-SPF: pass client-ip=192.55.52.88; envelope-from=zhao1.liu@intel.com;
 helo=mgamail.intel.com
X-Spam_score_int: -72
X-Spam_score: -7.3
X-Spam_bar: -------
X-Spam_report: (-7.3 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-2.851,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_MED=-2.3, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

Hi Philippe,

On Tue, Dec 26, 2023 at 04:04:41PM +0100, Philippe Mathieu-Daudé wrote:
> Date: Tue, 26 Dec 2023 16:04:41 +0100
> From: Philippe Mathieu-Daudé <philmd@linaro.org>
> Subject: [PATCH] docs/devel: Document conventional file prefixes and
>  suffixes
> X-Mailer: git-send-email 2.41.0
> 
> Some header and source file names use common prefix / suffix
> but we never really ruled a convention. Start doing so with
> the current patterns from the tree.
> 
> Suggested-by: Alex Bennée <alex.bennee@linaro.org>
> Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
> ---
>  docs/devel/style.rst | 49 ++++++++++++++++++++++++++++++++++++++++++++
>  1 file changed, 49 insertions(+)
> 
> diff --git a/docs/devel/style.rst b/docs/devel/style.rst
> index 2f68b50079..4da50eb2ea 100644
> --- a/docs/devel/style.rst
> +++ b/docs/devel/style.rst
> @@ -162,6 +162,55 @@ pre-processor. Another common suffix is ``_impl``; it is used for the
>  concrete implementation of a function that will not be called
>  directly, but rather through a macro or an inline function.
>  
> +File Naming Conventions
> +-----------------------
> +
> +Public headers
> +~~~~~~~~~~~~~~
> +
> +Headers expected to be access by multiple subsystems must reside in
> +the ``include/`` folder. Headers local to a subsystem should reside in
> +the sysbsystem folder, if any (for example ``qobject/qobject-internal.h``
> +can only be included by files within the ``qobject/`` folder).
> +
> +Header file prefix and suffix hints
> +~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
> +
> +When headers relate to common concept, it is useful to use a common
> +prefix or suffix.
> +
> +When headers relate to the same (guest) subsystem, the subsystem name is
> +often used as prefix. If headers are already in a folder named as the
> +subsystem, prefixing them is optional.
> +
> +For example, hardware models related to the Aspeed systems are named
> +using the ``aspeed_`` prefix.
> +
> +Headers related to the same (host) concept can also use a common prefix.
                                                                    ^^^^^^
                                                             Maybe "suffix"?

since below you provide examples of "suffix".

> +For example OS specific headers use the ``-posix`` and ``-win32`` suffixes.
> +
> +Registered file suffixes
> +~~~~~~~~~~~~~~~~~~~~~~~~
> +
> +* ``.inc``
> +
> +  Source files meant to be included by other source files as templates
> +  must use the ``.c.inc`` suffix. Similarly, headers meant to be included
> +  multiple times as template must use the ``.h.inc`` suffix.
> +
> +Recommended file prefixes / suffixes
> +~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
> +
> +* ``target`` and ``common`` suffixes
> +
> +  Files which are specific to a target should use the ``target`` suffix.

emm, it seems linux-use/* and bsd-user/* have many ``target`` prefix
headers. Should they get cleaned up?


> +  Such ``target`` suffixed headers usually *taint* the files including them
> +  by making them target specific.
> +
> +  Files common to all targets should use the ``common`` suffix, to provide
> +  a hint that these files can be safely included from common code.
> +
> +

An additional question that kind of confuses me is whether header file
naming should use "-" or "_" to connect prefixes/suffixes?

>  Block structure
>  ===============
>  
> -- 
> 2.41.0
> 

Thanks,
Zhao



