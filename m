Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 0B0AF77E4B0
	for <lists+qemu-devel@lfdr.de>; Wed, 16 Aug 2023 17:08:48 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qWI6J-000152-Kv; Wed, 16 Aug 2023 11:06:23 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1qWI66-00011B-3J
 for qemu-devel@nongnu.org; Wed, 16 Aug 2023 11:06:11 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1qWI60-0004s7-B1
 for qemu-devel@nongnu.org; Wed, 16 Aug 2023 11:06:08 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1692198362;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=qMT2tfBHu99+g/kMRbOXToex1rIPKJj03m6OEqKWbrI=;
 b=ReHUtYQaa1Ms9UUoZSqxwLPbGQEcB/MORfAF8Za3P2yNTSnRKazBGaid/ECz8nrFdlOY3b
 gD0YfK3lMSVj1Vhv3XOIPqeA3sKO7mhPh3Xcql2Q/YlwjUz+hU8Y9dnzcyDrY2r+K0PKSK
 jr2WMNXrgxaxYurWzFR1MjWB1fnZb9w=
Received: from mail-qv1-f70.google.com (mail-qv1-f70.google.com
 [209.85.219.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-682-ecVPy2gqNn2Rj8DBznaC3Q-1; Wed, 16 Aug 2023 11:06:01 -0400
X-MC-Unique: ecVPy2gqNn2Rj8DBznaC3Q-1
Received: by mail-qv1-f70.google.com with SMTP id
 6a1803df08f44-63c9463c116so18445926d6.0
 for <qemu-devel@nongnu.org>; Wed, 16 Aug 2023 08:06:01 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1692198361; x=1692803161;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=qMT2tfBHu99+g/kMRbOXToex1rIPKJj03m6OEqKWbrI=;
 b=guPI7l+FJhOfoSYNl+LJUKC8x/TeVn+PcXKYWRPhLJcRYcDwH0qNeSKiVZE11FwBWy
 ZH2hAHKY4j4AhWqvpzea+aIK5Imr1ZRSA/hFO1PArKVmWU5kqgThGti2z1rGP177OaYS
 CDFQ7SH5B9PrakiKgAs173aZjp5lpT8iQ7CW0ZyBcJZtYxocsDaYP1b5xR3Mj0VSKmM4
 baOo6ziwVXKYrsBPX6lO2BRa7hNjPpYeXDU7946YjgomxzlFEoqwfzXImM3jwthq8z9t
 tRoU6CEPeMiHL4DLJP0WCy6W++4DH4ps/cnNsvYv8/sxz9oue3FByljoE2F8m82C9+uD
 DfhQ==
X-Gm-Message-State: AOJu0YyT9l3R5CWqaRdI0LONk7N3RoZBEJeaZ6e0i3IHpcZlricDtXwe
 niOOIOczyK7opmzibGn5k/WU/NlGYL0TIVFimKtf9cHj8m0YW8XS4MMBvEW5daJWiYEHk8j21I4
 G3TOKgkc1ABnqmj0=
X-Received: by 2002:a05:6214:242e:b0:62b:6c6f:b3e3 with SMTP id
 gy14-20020a056214242e00b0062b6c6fb3e3mr2407773qvb.3.1692198360866; 
 Wed, 16 Aug 2023 08:06:00 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGJhtPGTVqNw7JeQg47H3L1tncgui9tOHDR63k7Y0squRSwxsEN1k5UfWq27IhWQdmjtgf8aA==
X-Received: by 2002:a05:6214:242e:b0:62b:6c6f:b3e3 with SMTP id
 gy14-20020a056214242e00b0062b6c6fb3e3mr2407757qvb.3.1692198360627; 
 Wed, 16 Aug 2023 08:06:00 -0700 (PDT)
Received: from x1n (cpe5c7695f3aee0-cm5c7695f3aede.cpe.net.cable.rogers.com.
 [99.254.144.39]) by smtp.gmail.com with ESMTPSA id
 u11-20020a0cdd0b000000b0063d0f1db105sm4903676qvk.32.2023.08.16.08.06.00
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 16 Aug 2023 08:06:00 -0700 (PDT)
Date: Wed, 16 Aug 2023 11:05:59 -0400
From: Peter Xu <peterx@redhat.com>
To: Fabiano Rosas <farosas@suse.de>
Cc: qemu-devel@nongnu.org, Juan Quintela <quintela@redhat.com>,
 Wei Wang <wei.w.wang@intel.com>, Leonardo Bras <leobras@redhat.com>
Subject: Re: [PATCH v4 2/8] migration: Fix possible races when shutting down
 the return path
Message-ID: <ZNzl1xXksUEex+OP@x1n>
References: <20230816142510.5637-1-farosas@suse.de>
 <20230816142510.5637-3-farosas@suse.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20230816142510.5637-3-farosas@suse.de>
Received-SPF: pass client-ip=170.10.133.124; envelope-from=peterx@redhat.com;
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

On Wed, Aug 16, 2023 at 11:25:04AM -0300, Fabiano Rosas wrote:
> We cannot call qemu_file_shutdown() on the return path file without
> taking the file lock. The return path thread could be running it's
> cleanup code and have just cleared the from_dst_file pointer.
> 
> Checking ms->to_dst_file for errors could also race with
> migrate_fd_cleanup() which clears the to_dst_file pointer.
> 
> Protect both accesses by taking the file lock.
> 
> This was caught by inspection, it should be rare, but the next patches
> will start calling this code from other places, so let's do the
> correct thing.
> 
> Signed-off-by: Fabiano Rosas <farosas@suse.de>

Reviewed-by: Peter Xu <peterx@redhat.com>

-- 
Peter Xu


