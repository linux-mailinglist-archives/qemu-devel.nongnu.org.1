Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 0296C742DE7
	for <lists+qemu-devel@lfdr.de>; Thu, 29 Jun 2023 21:58:19 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qExl7-0005x9-6s; Thu, 29 Jun 2023 15:56:53 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1qExl1-0005x1-I1
 for qemu-devel@nongnu.org; Thu, 29 Jun 2023 15:56:47 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1qExkz-0007Pk-Vj
 for qemu-devel@nongnu.org; Thu, 29 Jun 2023 15:56:47 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1688068604;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=DhnY9kXLA79hE13iH1ozRYuOba8aubNRYH9w/LuNcpo=;
 b=Safo5qAXTJ1ijMcvMRWnG4l3xWTDnJEUj5TUERjVUO8j5zq0h0DkYJVvC6zJtrxhyY5S/9
 mQH5BgR52BEbueWpbknXNyzxI5yqdZeYFzdZynSPuxgHPtBtQ/hTxbw6acI0OWfFHsd/Zw
 U0U2sQO/3JDuD5uzjBYgVpZhXW3LvRY=
Received: from mail-qv1-f69.google.com (mail-qv1-f69.google.com
 [209.85.219.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-119-97jHO9CHNuuT1mlTBhmlMg-1; Thu, 29 Jun 2023 15:56:43 -0400
X-MC-Unique: 97jHO9CHNuuT1mlTBhmlMg-1
Received: by mail-qv1-f69.google.com with SMTP id
 6a1803df08f44-635eb5b04e1so2235966d6.1
 for <qemu-devel@nongnu.org>; Thu, 29 Jun 2023 12:56:42 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1688068602; x=1690660602;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=DhnY9kXLA79hE13iH1ozRYuOba8aubNRYH9w/LuNcpo=;
 b=BVx0MWPImCVTfAHYrOJ82wCg1XGNGEz8azthzlBa7Kqhjo1ddSUfFgLVIYIl80jsI8
 cCPWVSA5+s11Kq8RP1wmfZWPm5srEO2R8CP9iUBDcGqmuYD3LJmtrEp2dwRm1DtpTuyK
 Cieh6LMhYAYZrvSMNhspNa1TnzoE+qaiI0CnPpTs3RpjGcet0Tm+XSb1/HGET/yImpHX
 T8fAVzyPRNUzIhHHuzy2MaQEIAIx0O4rJie9T/RvRV3qf5LdtnLGmOfB/jUNOFqspZ60
 nZhuUF4xLdqkwXcxGo30yHklOb5ft3/y/lHFQznwZYqGfscazyHqpdK9agy4mrLCvdjB
 Cplg==
X-Gm-Message-State: ABy/qLZIaZtnoV/giE3D3wkk+pMW2W3KqLhvx8ldzVx+4q0XEBpBQQj2
 51ZChh8D18ml/dJzfHkqPAyz6F9trdF/UrP74fx5oXrrY6anUzIwEC2wDTWbgUS+SBBgHIfBs8o
 jveOdcnsPLvRmmyE=
X-Received: by 2002:a05:6214:411c:b0:625:77a1:2a5f with SMTP id
 kc28-20020a056214411c00b0062577a12a5fmr633637qvb.5.1688068602152; 
 Thu, 29 Jun 2023 12:56:42 -0700 (PDT)
X-Google-Smtp-Source: APBJJlGG75CpZ7dIBirURWhRjMg8lg+P1yfEJbeH3XuNMDxicXNx1OwI+Tzcdt4XuxA9Fa9vtbw/SQ==
X-Received: by 2002:a05:6214:411c:b0:625:77a1:2a5f with SMTP id
 kc28-20020a056214411c00b0062577a12a5fmr633625qvb.5.1688068601846; 
 Thu, 29 Jun 2023 12:56:41 -0700 (PDT)
Received: from x1n (cpe5c7695f3aee0-cm5c7695f3aede.cpe.net.cable.rogers.com.
 [99.254.144.39]) by smtp.gmail.com with ESMTPSA id
 ec17-20020ad44e71000000b00632191a70a2sm7175680qvb.103.2023.06.29.12.56.41
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 29 Jun 2023 12:56:41 -0700 (PDT)
Date: Thu, 29 Jun 2023 15:56:39 -0400
From: Peter Xu <peterx@redhat.com>
To: Fabiano Rosas <farosas@suse.de>
Cc: qemu-devel@nongnu.org, Leonardo Bras Soares Passos <lsoaresp@redhat.com>,
 Juan Quintela <quintela@redhat.com>, Lukas Straub <lukasstraub2@web.de>
Subject: Re: [PATCH 5/7] migration: Display error in query-migrate irrelevant
 of status
Message-ID: <ZJ3h91f+avD0jNtk@x1n>
References: <20230628215002.73546-1-peterx@redhat.com>
 <20230628215002.73546-6-peterx@redhat.com> <87y1k3p4xp.fsf@suse.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <87y1k3p4xp.fsf@suse.de>
Received-SPF: pass client-ip=170.10.129.124; envelope-from=peterx@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

On Wed, Jun 28, 2023 at 08:01:22PM -0300, Fabiano Rosas wrote:
> Peter Xu <peterx@redhat.com> writes:
> 
> > Display it as long as being set, irrelevant of FAILED status.  E.g., it may
> > also be applicable to PAUSED stage of postcopy, to provide hint on what has
> > gone wrong.
> 
> This might have made the documentation slightly inaccurate:

Hmm yes, maybe I should touch that up so as to include "postcopy-paused",
or just remove the statement that it must be in a "failed" stage.

> 
> # @error-desc: the human readable error description string, when
> #     @status is 'failed'. Clients should not attempt to parse the
> #     error strings.  (Since 2.7)
> 
> But it's not wrong, so:
> 
> Reviewed-by: Fabiano Rosas <farosas@suse.de>

Thanks for taking a look.

-- 
Peter Xu


