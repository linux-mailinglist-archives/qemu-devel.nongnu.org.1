Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 0F3717DD3A5
	for <lists+qemu-devel@lfdr.de>; Tue, 31 Oct 2023 18:01:06 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qxs5a-00055k-BF; Tue, 31 Oct 2023 12:59:38 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dg@treblig.org>)
 id 1qxs5X-00055N-1t; Tue, 31 Oct 2023 12:59:35 -0400
Received: from mx.treblig.org ([2a00:1098:5b::1])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dg@treblig.org>)
 id 1qxs5U-0001GC-UV; Tue, 31 Oct 2023 12:59:34 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=treblig.org
 ; s=bytemarkmx;
 h=In-Reply-To:Content-Type:MIME-Version:References:Message-ID
 :Subject:Cc:To:From:Date:Sender:Reply-To:Content-Transfer-Encoding:Content-ID
 :Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:
 Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe
 :List-Post:List-Owner:List-Archive;
 bh=o6QCrANTa1eLNawlpRojH/LXzgyvuBRrFbnDH/HskMI=; b=rS0lHfU23KV3QnYldGdgAUZblg
 lEt/f/rFG2CZdIVBEVtHQmvS5GYtS+RXSCznP2uiWCd5IeoPUschfXM5XdB4Et7q/pF6h9RRqs8vS
 tgSLTvr4VRstbl6CBeb/JXQv1qHC8eAE5VkZm0U8UHs5VMSeTfnZs3AlLo4wW0rynI8hIRpGhg/ay
 CICjsk/4Yg/ImRTsLef0x64DnVNO60e3L0x9oV43cf0AdwacEtnJBycOQ8VVMNsYsPuBtl/G+WUPc
 AMPNAS1DirPLyl8ZUGnXfSaNV287Jd6kF82Imedv49dCGE2AvMoVvWEBRSPEw9J7M+x3EEZ+dIFwe
 TLefqu3Q==;
Received: from dg by mx.treblig.org with local (Exim 4.96)
 (envelope-from <dg@treblig.org>) id 1qxs5A-007HSh-1l;
 Tue, 31 Oct 2023 16:59:12 +0000
Date: Tue, 31 Oct 2023 16:59:12 +0000
From: "Dr. David Alan Gilbert" <dave@treblig.org>
To: Markus Armbruster <armbru@redhat.com>
Cc: qemu-devel@nongnu.org, philmd@linaro.org, npiggin@gmail.com,
 danielhb413@gmail.com, clg@kaod.org, david@gibson.dropbear.id.au,
 harshpb@linux.ibm.com, jasowang@redhat.com, michael.roth@amd.com,
 kkostiuk@redhat.com, mst@redhat.com, david@redhat.com,
 kraxel@redhat.com, marcandre.lureau@redhat.com, qemu-ppc@nongnu.org
Subject: Re: [PATCH 2/7] hmp: Improve sync-profile error message
Message-ID: <ZUEyYAUO3Xb3kJoY@gallifrey>
References: <20231031111059.3407803-1-armbru@redhat.com>
 <20231031111059.3407803-3-armbru@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
In-Reply-To: <20231031111059.3407803-3-armbru@redhat.com>
X-Chocolate: 70 percent or better cocoa solids preferably
X-Operating-System: Linux/6.1.0-12-amd64 (x86_64)
X-Uptime: 16:57:56 up 45 days, 19:56, 1 user, load average: 0.00, 0.01, 0.00
User-Agent: Mutt/2.2.12 (2023-09-09)
Received-SPF: pass client-ip=2a00:1098:5b::1; envelope-from=dg@treblig.org;
 helo=mx.treblig.org
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001, T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

* Markus Armbruster (armbru@redhat.com) wrote:
> Improve
> 
>     (qemu) sync-profile of
>     Error: Invalid parameter 'of'
> 
> to
> 
>     Error: invalid parameter 'of', expecting 'on', 'off', or 'reset'
> 
> Signed-off-by: Markus Armbruster <armbru@redhat.com>

Reviewed-by: Dr. David Alan Gilbert <dave@treblig.org>

> ---
>  monitor/hmp-cmds.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/monitor/hmp-cmds.c b/monitor/hmp-cmds.c
> index 6c559b48c8..871898ac46 100644
> --- a/monitor/hmp-cmds.c
> +++ b/monitor/hmp-cmds.c
> @@ -24,7 +24,6 @@
>  #include "qapi/qapi-commands-control.h"
>  #include "qapi/qapi-commands-misc.h"
>  #include "qapi/qmp/qdict.h"
> -#include "qapi/qmp/qerror.h"
>  #include "qemu/cutils.h"
>  #include "hw/intc/intc.h"
>  #include "qemu/log.h"
> @@ -138,7 +137,8 @@ void hmp_sync_profile(Monitor *mon, const QDict *qdict)
>      } else {
>          Error *err = NULL;
>  
> -        error_setg(&err, QERR_INVALID_PARAMETER, op);
> +        error_setg(&err, "invalid parameter '%s',"
> +                   " expecting 'on', 'off', or 'reset'", op);
>          hmp_handle_error(mon, err);
>      }
>  }
> -- 
> 2.41.0
> 
-- 
 -----Open up your eyes, open up your mind, open up your code -------   
/ Dr. David Alan Gilbert    |       Running GNU/Linux       | Happy  \ 
\        dave @ treblig.org |                               | In Hex /
 \ _________________________|_____ http://www.treblig.org   |_______/

