Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 9D3A17FA35B
	for <lists+qemu-devel@lfdr.de>; Mon, 27 Nov 2023 15:47:19 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1r7ct8-0005aS-9I; Mon, 27 Nov 2023 09:47:06 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1r7cst-0005ZG-UX
 for qemu-devel@nongnu.org; Mon, 27 Nov 2023 09:46:56 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1r7css-00032t-HY
 for qemu-devel@nongnu.org; Mon, 27 Nov 2023 09:46:51 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1701096409;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=8a4Bc1ZgydInAx3A5WsRUtP/bExujU6o+9c+FuQ+F60=;
 b=g/rSvh8pa8SvZt4z1tTIE+JlZ1/DhZeU6Dv6Qos1FjMLn4saeGe1pogWhIJ0AZA/4fPD/H
 kLmO76TFTvcWwv9tdgKeTlaZZ33ZL0RCgEYqKWONQNHdJqA9D20i9HcFp+ujK/BdQlmmco
 XxKg97+pR3wSkUmYgslHOIuH70tbQh0=
Received: from mail-qk1-f198.google.com (mail-qk1-f198.google.com
 [209.85.222.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-641-KVo2Pvv3M_SGpFTIZp7gUg-1; Mon, 27 Nov 2023 09:46:48 -0500
X-MC-Unique: KVo2Pvv3M_SGpFTIZp7gUg-1
Received: by mail-qk1-f198.google.com with SMTP id
 af79cd13be357-77d683d5775so108710085a.0
 for <qemu-devel@nongnu.org>; Mon, 27 Nov 2023 06:46:48 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1701096408; x=1701701208;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=8a4Bc1ZgydInAx3A5WsRUtP/bExujU6o+9c+FuQ+F60=;
 b=cMxj2r90e2b6NLUxsmY2SuXRlMVMubZS80fOaSCPjLEho7nzTaDhLNYde6nMcrAB5C
 ivOSqPZ3zLKNee3m1KeJOVbyAR+b+UEH5ukTx/iWqizRWUDBQqXsTI2MU9k8rMcH95Uf
 Bv4QQ78XV+F2DJyCKvsJ/Wa9Pkr41WOI42qrbkG+jy/x+U5UcuNoC/38cRJqSukTmSwn
 mYIsdpYS9ST+zoxWkdCh94hkNQSsxqIlxjuhxOYP/HhbWutyjoIdOJo4FpvbC/cGzXIT
 Nx9VKDE4rjw0hcpU6fnd2+lyNB3Sob0ymbX33ypWR8wekpQB0iT+dUNI8MhHKd6vFza7
 Uw2g==
X-Gm-Message-State: AOJu0YyVnetvfvgcf8NQmhUcroTMSZAhfOx5IdWQoggG4162wk+1Zi/F
 CQ4nguytA1zlKj7F5x/qjQY1ltPfnqMlpEmlIvgQoSbQY2Gs9BUe1mEYd1lvC+iH71A6NgkOVa4
 UGODM9GJ09tMWx+8=
X-Received: by 2002:a05:620a:46a4:b0:77d:8aa8:fbda with SMTP id
 bq36-20020a05620a46a400b0077d8aa8fbdamr9835330qkb.4.1701096407801; 
 Mon, 27 Nov 2023 06:46:47 -0800 (PST)
X-Google-Smtp-Source: AGHT+IELMaySaqKgiAedwQO+njozX6D5nlEwRP8OvK0cMCZoE/bF9uWU+8j6758zVgUBUYvi7TLMhA==
X-Received: by 2002:a05:620a:46a4:b0:77d:8aa8:fbda with SMTP id
 bq36-20020a05620a46a400b0077d8aa8fbdamr9835314qkb.4.1701096407562; 
 Mon, 27 Nov 2023 06:46:47 -0800 (PST)
Received: from x1n (cpe688f2e2cb7c3-cm688f2e2cb7c0.cpe.net.cable.rogers.com.
 [99.254.121.117]) by smtp.gmail.com with ESMTPSA id
 g14-20020a05620a13ce00b0077da0832d6csm1350429qkl.22.2023.11.27.06.46.46
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 27 Nov 2023 06:46:47 -0800 (PST)
Date: Mon, 27 Nov 2023 09:46:46 -0500
From: Peter Xu <peterx@redhat.com>
To: Fabiano Rosas <farosas@suse.de>
Cc: qemu-devel@nongnu.org, Juan Quintela <quintela@redhat.com>,
 Leonardo Bras <leobras@redhat.com>
Subject: Re: [PATCH v1 4/7] migration: Report error in incoming migration
Message-ID: <ZWSr1gK_Qo18rv4x@x1n>
References: <20231124161432.3515-1-farosas@suse.de>
 <20231124161432.3515-5-farosas@suse.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20231124161432.3515-5-farosas@suse.de>
Received-SPF: pass client-ip=170.10.129.124; envelope-from=peterx@redhat.com;
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
Errors-To: qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org
Sender: qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org

On Fri, Nov 24, 2023 at 01:14:29PM -0300, Fabiano Rosas wrote:
> We're not currently reporting the errors set with migrate_set_error()
> when incoming migration fails.
> 
> Signed-off-by: Fabiano Rosas <farosas@suse.de>

Reviewed-by: Peter Xu <peterx@redhat.com>

-- 
Peter Xu


