Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 231FA7DF424
	for <lists+qemu-devel@lfdr.de>; Thu,  2 Nov 2023 14:43:18 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qyXxK-0002hW-MI; Thu, 02 Nov 2023 09:41:54 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1qyXxH-0002fr-VZ
 for qemu-devel@nongnu.org; Thu, 02 Nov 2023 09:41:52 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1qyXxG-0001Rq-Ed
 for qemu-devel@nongnu.org; Thu, 02 Nov 2023 09:41:51 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1698932508;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=LHBXPyLyEL5V2TtBWE6+GwS56A5EjUtxYj5WmooWgXI=;
 b=W64+Hv5uj+VLnLvpWZOsmT937Ly+TWQnDv/vhEPlW+PwlvsHUuQtsstn2gSAhdmjMrYvi4
 wKB8O8LEKrW4rwVLseLTXVhHLGaRZZQyYlwWgT8MjpfELacTWBfK2tKyz0RJSD6jJa94GM
 L7Js5h7eSUBDFeOVSN+04dBv016Y99A=
Received: from mail-qt1-f200.google.com (mail-qt1-f200.google.com
 [209.85.160.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-30-jqoMa2o0Oj-I81HBZwU5Zg-1; Thu, 02 Nov 2023 09:41:47 -0400
X-MC-Unique: jqoMa2o0Oj-I81HBZwU5Zg-1
Received: by mail-qt1-f200.google.com with SMTP id
 d75a77b69052e-41e1d5557a9so1146521cf.0
 for <qemu-devel@nongnu.org>; Thu, 02 Nov 2023 06:41:47 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1698932506; x=1699537306;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=LHBXPyLyEL5V2TtBWE6+GwS56A5EjUtxYj5WmooWgXI=;
 b=QIg5d8gX3vL5ZxQntm+PrrzvMTNBhTMnRvL0nZaDUSx6RCr1fiIBDME2FfoEJmexTV
 wyEqvZUSVNk7KTfPYsRJMaSBpEZjWup7ZRU3XWhEacJfLjU4OF1NW+cxwdav6LOKL6OZ
 /B9GSjSUseNlRTK+jK0uR4B9JDuh93lBuCL5bDKD0AwObJgtj4dk5NHDvumyz+frWM1W
 +mYEPtKHTWtXJCtchV5O/uEGwpOHgqNtboCljlT6CpMMxINpjyVz0T1FEJTWbcD6eoKy
 U/qZ3T1rDM3qGN9EjSZiLYtI2fi26ByDbPXDOUZewYzd+MhMt7pYdS6I40NsrizJThIm
 YIKA==
X-Gm-Message-State: AOJu0YxoHzz1U4m2vUb8lSTfD8JNRZZ0pI2E3AL8q8MuHj8PWn8lyxYN
 kbKY9Sg3hr7Kcs9NJmkzrQE09GodLXQBEmJUPcqTZj7MK4TMH9iO3xfEabMoOtCiMhy0oTIXrQp
 QZmp7BnFTtuByHwY=
X-Received: by 2002:a05:622a:1a26:b0:41c:c829:ab2b with SMTP id
 f38-20020a05622a1a2600b0041cc829ab2bmr22112897qtb.1.1698932506611; 
 Thu, 02 Nov 2023 06:41:46 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEigAXYI3LRKiiYMidOWeDbTQBYgoAFHa4lrzzMYoR6e3K7cnxoLeP99C1r/M2/jqHLffNiow==
X-Received: by 2002:a05:622a:1a26:b0:41c:c829:ab2b with SMTP id
 f38-20020a05622a1a2600b0041cc829ab2bmr22112881qtb.1.1698932506256; 
 Thu, 02 Nov 2023 06:41:46 -0700 (PDT)
Received: from x1n (cpe5c7695f3aee0-cm5c7695f3aede.cpe.net.cable.rogers.com.
 [99.254.144.39]) by smtp.gmail.com with ESMTPSA id
 e3-20020a05622a110300b00419714dd0b9sm2263147qty.62.2023.11.02.06.41.45
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 02 Nov 2023 06:41:45 -0700 (PDT)
Date: Thu, 2 Nov 2023 09:41:43 -0400
From: Peter Xu <peterx@redhat.com>
To: Juan Quintela <quintela@redhat.com>
Cc: qemu-devel@nongnu.org, Fabiano Rosas <farosas@suse.de>,
 Leonardo Bras <leobras@redhat.com>
Subject: Re: [PATCH] migration: Unlock mutex in error case
Message-ID: <ZUOnFxnHOrwuwPtI@x1n>
References: <20231102091245.42045-1-quintela@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20231102091245.42045-1-quintela@redhat.com>
Received-SPF: pass client-ip=170.10.133.124; envelope-from=peterx@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -24
X-Spam_score: -2.5
X-Spam_bar: --
X-Spam_report: (-2.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.393,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

On Thu, Nov 02, 2023 at 10:12:45AM +0100, Juan Quintela wrote:
> We were not unlocking bitmap mutex on the error case.
> Coverity discovered the problem.
> 
> Fixes: a2326705e5 ("migration: Stop migration immediately in RDMA error paths")
> Signed-off-by: Juan Quintela <quintela@redhat.com>
> ---
>  migration/ram.c | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/migration/ram.c b/migration/ram.c
> index 34724e8fe8..8c4df60f29 100644
> --- a/migration/ram.c
> +++ b/migration/ram.c
> @@ -3040,6 +3040,7 @@ static int ram_save_iterate(QEMUFile *f, void *opaque)
>          ret = rdma_registration_start(f, RAM_CONTROL_ROUND);
>          if (ret < 0) {
>              qemu_file_set_error(f, ret);
> +            qemu_mutex_unlock(&rs->bitmap_mutex);
>              goto out;
>          }

Reviewed-by: Peter Xu <peterx@redhat.com>

-- 
Peter Xu


