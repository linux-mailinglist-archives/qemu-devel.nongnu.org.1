Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id A76BF77E8F3
	for <lists+qemu-devel@lfdr.de>; Wed, 16 Aug 2023 20:44:30 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qWLU6-0000qA-IU; Wed, 16 Aug 2023 14:43:10 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1qWLU4-0000Oa-7k
 for qemu-devel@nongnu.org; Wed, 16 Aug 2023 14:43:08 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1qWLU1-0002Ce-Ui
 for qemu-devel@nongnu.org; Wed, 16 Aug 2023 14:43:07 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1692211384;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=SlA3W8xeTnNsJupOQ+V3ZVyAmWKckNpC9NzN17zdpmk=;
 b=Ep6qwT04qvH568f8bXzlVhvYjKaH1lzkI0KALuJf/1Qp+X7IGG9s23Gx6uv31maCCXMW9f
 tDlQR1kpQwDe26vzERtnNjbdeLISgSeASvlQFNjWM09GaH4o681dVl87J5EpPQeeAI6+z0
 1fsxsT0T5MDyQKGLFhh1khDWDTIdFeU=
Received: from mail-qk1-f197.google.com (mail-qk1-f197.google.com
 [209.85.222.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-382-UofUMcwhNpmdTZ_my-EjFA-1; Wed, 16 Aug 2023 14:43:01 -0400
X-MC-Unique: UofUMcwhNpmdTZ_my-EjFA-1
Received: by mail-qk1-f197.google.com with SMTP id
 af79cd13be357-76cde638658so234287485a.1
 for <qemu-devel@nongnu.org>; Wed, 16 Aug 2023 11:43:01 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1692211381; x=1692816181;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=SlA3W8xeTnNsJupOQ+V3ZVyAmWKckNpC9NzN17zdpmk=;
 b=ivgol041+T3EsrH/SyWeUd5d672xET9uoEV/BwpmxTJmBNbOM3x1bD/HTOaogaTJgS
 kn0F0GVknRls3y0o0UlB6whIr7OENNuW6PkjAgJXkqs/WGnrhF3lGiJkkoMUu+2MB9oP
 JUvUDGV3f2s6FFvF+JI1XzxBvMXQSFGWvqoZVxAwoBgUNcP49zhtXgfn03T6kmbdK+LK
 I8mGbTtpEkyZRMbFT2QpPElKylM7CUd3MX9AcD4V01w9kkandgWZ8Q5+fuOcMlt5NdLV
 Z26lF2Sg+ZMZi2o3F280SRtOpgp+BYSp1JAT8KWumj9QmhI/j7wZ5hk0DmVNly+fVNGo
 /u9w==
X-Gm-Message-State: AOJu0YzqLDMqMJl+UPFXtCu754X5hGy4pNjCHciUJerB39yZLmYqcgBE
 otlcYIYNFsas0nZKdyIW5i1YhvFbLYODb4noXKGjJKa1e+dbXVoXyfrquNcLE3SMD667P8r9Y0Z
 mWRh/xepL1LWL2GhxJ+JnkqA=
X-Received: by 2002:a05:620a:199c:b0:75b:23a1:69ee with SMTP id
 bm28-20020a05620a199c00b0075b23a169eemr3300168qkb.5.1692211381258; 
 Wed, 16 Aug 2023 11:43:01 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IF+6ODpGqeVofgUrQ/JXqBJZFnWKpHGxjdhzRjou23Ns3AVj0nUm8v+emAH2T8Lmguof3lpvQ==
X-Received: by 2002:a05:620a:199c:b0:75b:23a1:69ee with SMTP id
 bm28-20020a05620a199c00b0075b23a169eemr3300157qkb.5.1692211381021; 
 Wed, 16 Aug 2023 11:43:01 -0700 (PDT)
Received: from x1n (cpe5c7695f3aee0-cm5c7695f3aede.cpe.net.cable.rogers.com.
 [99.254.144.39]) by smtp.gmail.com with ESMTPSA id
 s29-20020a05620a031d00b00767e62bcf0csm4570923qkm.65.2023.08.16.11.43.00
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 16 Aug 2023 11:43:00 -0700 (PDT)
Date: Wed, 16 Aug 2023 14:42:59 -0400
From: Peter Xu <peterx@redhat.com>
To: Fabiano Rosas <farosas@suse.de>
Cc: qemu-devel@nongnu.org, Juan Quintela <quintela@redhat.com>,
 Leonardo Bras <leobras@redhat.com>
Subject: Re: [PATCH v2 4/4] migration/ram: Merge save_zero_page functions
Message-ID: <ZN0Ys7YireLQVm4o@x1n>
References: <20230816182817.17590-1-farosas@suse.de>
 <20230816182817.17590-5-farosas@suse.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20230816182817.17590-5-farosas@suse.de>
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

On Wed, Aug 16, 2023 at 03:28:17PM -0300, Fabiano Rosas wrote:
> We don't need to do this in two pieces. One single function makes it
> easier to grasp, specially since it removes the indirection on the
> return value handling.
> 
> Signed-off-by: Fabiano Rosas <farosas@suse.de>

Reviewed-by: Peter Xu <peterx@redhat.com>

-- 
Peter Xu


