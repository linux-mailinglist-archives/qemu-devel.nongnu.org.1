Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 8DAE6712EBF
	for <lists+qemu-devel@lfdr.de>; Fri, 26 May 2023 23:11:18 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1q2ehB-0001Nb-Kl; Fri, 26 May 2023 17:09:57 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1q2ehA-0001NF-5T
 for qemu-devel@nongnu.org; Fri, 26 May 2023 17:09:56 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1q2eh8-0004Jb-Kj
 for qemu-devel@nongnu.org; Fri, 26 May 2023 17:09:55 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1685135393;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=QErzhsH3SHRCp6zWHlh5r6VEIlJ6PY0VgvtYk2IPDpc=;
 b=Bh27BnnRDJWgPURV8xbm3DuPALaqD5W9OxAaU5TDeWHBteOExifzae8KNxw7joAbCx/Ef7
 qrsUtsUUA9KfP/AwKjATdg2YXMDNoEY2FO+bG1sneOU7lDZTkBPteIhVLESc8Thxi3EG+G
 E5I7kbGvzLwv+10DzXF0SnWuiymUT/Q=
Received: from mail-qv1-f71.google.com (mail-qv1-f71.google.com
 [209.85.219.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-436-nzkQQncUMKqiQ4ngzw3a_Q-1; Fri, 26 May 2023 17:09:52 -0400
X-MC-Unique: nzkQQncUMKqiQ4ngzw3a_Q-1
Received: by mail-qv1-f71.google.com with SMTP id
 6a1803df08f44-623a54565e6so2235526d6.0
 for <qemu-devel@nongnu.org>; Fri, 26 May 2023 14:09:52 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1685135391; x=1687727391;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=QErzhsH3SHRCp6zWHlh5r6VEIlJ6PY0VgvtYk2IPDpc=;
 b=RvTu7CtLHcBfGZv4ovYDdG+7GoMjjTwLhLrXvv0Vcm7k20h68N0SkG5DPom3vcohiG
 HwGH920i9rIJyw2vQvjgZ6jVST2PjW+V4aKghNhXQBemcXb10/Y6CEX9IkISgwLdPMQ6
 XKibJXFdKVkzlQMEDyn3DdA1vD/qJ9X8ijfIcnr/msTfDe3KujaLZszfkTIzfPzkt95v
 C7Xw+14QkCPKVXt1VB9nF3p7bnGmIUnCL+7PlRAQaUmIBM+cF7E0CiQKdjxruuvxpsUs
 ASk8L5aFhkRQeRwCc2JpvRMsMXGERUeZRilzosZQmCKpuMlQziejvB4/konnzaec3Phf
 NI0Q==
X-Gm-Message-State: AC+VfDx8d4yZ8/flGbEUI/3CDq4C/m5gJaGwWduPTm1QB5uVDQj6Fx7o
 EHT5EISjmOsRM9uGVOsrX6EUIJhq6s+mUM5uHY0cUgog24d7dA5OoSF1Q9EQJMemYMWt6tMhHmZ
 6X2hf8hhmEq8j7MZCE1Dmxcc=
X-Received: by 2002:a05:6214:528a:b0:61b:2111:c2e2 with SMTP id
 kj10-20020a056214528a00b0061b2111c2e2mr3427971qvb.2.1685135391602; 
 Fri, 26 May 2023 14:09:51 -0700 (PDT)
X-Google-Smtp-Source: ACHHUZ7neKPOpbSLE3jwGay6wimE3eCAygZr9ZSuz1+kHj1xUaHdXe9j0lgkzUMqHjxxPC5NgdgFXw==
X-Received: by 2002:a05:6214:528a:b0:61b:2111:c2e2 with SMTP id
 kj10-20020a056214528a00b0061b2111c2e2mr3427959qvb.2.1685135391365; 
 Fri, 26 May 2023 14:09:51 -0700 (PDT)
Received: from x1n (bras-base-aurron9127w-grc-62-70-24-86-62.dsl.bell.ca.
 [70.24.86.62]) by smtp.gmail.com with ESMTPSA id
 t23-20020a0cb397000000b005ef493c6bebsm1490684qve.77.2023.05.26.14.09.50
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 26 May 2023 14:09:50 -0700 (PDT)
Date: Fri, 26 May 2023 17:09:49 -0400
From: Peter Xu <peterx@redhat.com>
To: Juan Quintela <quintela@redhat.com>
Cc: qemu-devel@nongnu.org, Leonardo Bras <leobras@redhat.com>
Subject: Re: [PATCH 1/5] migration: Make RAM_SAVE_FLAG_HOOK a normal case entry
Message-ID: <ZHEgHRdmVcAI/054@x1n>
References: <20230504114443.23891-1-quintela@redhat.com>
 <20230504114443.23891-2-quintela@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20230504114443.23891-2-quintela@redhat.com>
Received-SPF: pass client-ip=170.10.133.124; envelope-from=peterx@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
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

On Thu, May 04, 2023 at 01:44:39PM +0200, Juan Quintela wrote:
> Fixes this commit, clearly a bad merge after a rebase or similar, it
> should have been its own case since that point.
> 
> commit 5b0e9dd46fbda5152566a4a26fd96bc0d0452bf7
> Author: Peter Lieven <pl@kamp.de>
> Date:   Tue Jun 24 11:32:36 2014 +0200
> 
>     migration: catch unknown flag combinations in ram_load
> 
> Signed-off-by: Juan Quintela <quintela@redhat.com>

Reviewed-by: Peter Xu <peterx@redhat.com>

-- 
Peter Xu


