Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 614CF771DA0
	for <lists+qemu-devel@lfdr.de>; Mon,  7 Aug 2023 11:56:56 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qSwyP-0001U9-Cy; Mon, 07 Aug 2023 05:56:25 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <imammedo@redhat.com>)
 id 1qSwyN-0001Tu-F7
 for qemu-devel@nongnu.org; Mon, 07 Aug 2023 05:56:23 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <imammedo@redhat.com>)
 id 1qSwyL-0005DS-PI
 for qemu-devel@nongnu.org; Mon, 07 Aug 2023 05:56:23 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1691402180;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=pYOSNGmUMytWtrYbNGDbuakocOYZ5VDtki+92y9QTr4=;
 b=FXjz8DyvOI/qTjqD/smxLofHLeFaumkWu+m4q4ZU4ruoqDYY/v/SGxQCf3v/pD4MshfccS
 B6juMWNhiO9uwgm5pKGRm91jP4zHLJLYrLmlg5MENcBQvcmBrPHeLVWuinPB5Np6YB2mSL
 GnrDUCJEc5FOQuIClsn7Ehqi+GpsKWQ=
Received: from mail-ed1-f71.google.com (mail-ed1-f71.google.com
 [209.85.208.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-74-MclEuGmoOa--UA7KhVdojA-1; Mon, 07 Aug 2023 05:56:18 -0400
X-MC-Unique: MclEuGmoOa--UA7KhVdojA-1
Received: by mail-ed1-f71.google.com with SMTP id
 4fb4d7f45d1cf-50daa85e940so3295861a12.0
 for <qemu-devel@nongnu.org>; Mon, 07 Aug 2023 02:56:18 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1691402177; x=1692006977;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=pYOSNGmUMytWtrYbNGDbuakocOYZ5VDtki+92y9QTr4=;
 b=Zh4fNYiacGo2Q4T9KaejrEqxpqOhzrj0rV69DSxuMZIu8++M/RjaYchJMXxob/RyWV
 cOZNmOLYUy7K8ZPX8F47hi0htn788RUCZ3UuaBk9DooH1ZUY0xs23cF7OVUqWppme5dI
 W3E9MQWUAtvI7LaH6/LM3275/Uo42e0z8mjaj+FCYf52h1piINq1NGA2RnKzfJ5QMj0x
 0ZeDFuQuXACtwCkcgqTyPRb6B/nQUn7fOv1yRJYLLLAFwPmuLfbyHCRuds1FS+sK/DaG
 4EU+DcQClzJUobpD9/QSj7cFGV4f6GoLccD9Vm12e8K8YgLHXZ3tL85xcocas7ftXTmy
 oT2Q==
X-Gm-Message-State: AOJu0YxPj3hB2KUESxzenkJ3uR/r9ueK/inSuosGVdlHBvSg3xxpaC3C
 xFj1pWLaVP/vT42ukru7V5MSGpLtO0xyHOpUNAZeU4l76ViEkyMnVUT+J08aW7v43nT793QBa70
 VZdoq4Dog3kNBeWI=
X-Received: by 2002:aa7:cd97:0:b0:51e:1643:5ad0 with SMTP id
 x23-20020aa7cd97000000b0051e16435ad0mr7437041edv.8.1691402177512; 
 Mon, 07 Aug 2023 02:56:17 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFtfWj/qcmzBFQv/Ult63nDAoZUZbV3G6B7WrJjhz8/mGSqyeUk29MbUtxDPvW2ouCtxHO/5A==
X-Received: by 2002:aa7:cd97:0:b0:51e:1643:5ad0 with SMTP id
 x23-20020aa7cd97000000b0051e16435ad0mr7437027edv.8.1691402177284; 
 Mon, 07 Aug 2023 02:56:17 -0700 (PDT)
Received: from imammedo.users.ipa.redhat.com (nat-pool-brq-t.redhat.com.
 [213.175.37.10]) by smtp.gmail.com with ESMTPSA id
 j18-20020aa7c0d2000000b0052239012c65sm4954759edp.82.2023.08.07.02.56.16
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 07 Aug 2023 02:56:16 -0700 (PDT)
Date: Mon, 7 Aug 2023 11:56:15 +0200
From: Igor Mammedov <imammedo@redhat.com>
To: Michael Tokarev <mjt@tls.msk.ru>
Cc: Zhao Liu <zhao1.liu@linux.intel.com>, "Michael S . Tsirkin"
 <mst@redhat.com>, Ani Sinha <anisinha@redhat.com>, qemu-devel@nongnu.org,
 Zhenyu Wang <zhenyu.z.wang@intel.com>, Zhao Liu <zhao1.liu@intel.com>
Subject: Re: [PATCH v2 2/3] hw/smbios: Fix thread count in type4
Message-ID: <20230807115615.278fb838@imammedo.users.ipa.redhat.com>
In-Reply-To: <32cfa897-4472-083f-88cd-a3c3e3c405b0@tls.msk.ru>
References: <20230601092952.1114727-1-zhao1.liu@linux.intel.com>
 <20230601092952.1114727-3-zhao1.liu@linux.intel.com>
 <598990ac-e5f8-fdcc-5936-e219491c4d0f@tls.msk.ru>
 <32cfa897-4472-083f-88cd-a3c3e3c405b0@tls.msk.ru>
X-Mailer: Claws Mail 4.1.1 (GTK 3.24.38; x86_64-redhat-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=170.10.133.124; envelope-from=imammedo@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=-0.01, RCVD_IN_MSPIKE_WL=-0.01,
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

On Sat, 5 Aug 2023 09:00:41 +0300
Michael Tokarev <mjt@tls.msk.ru> wrote:

> 05.08.2023 08:58, Michael Tokarev wrote:
> 
> > 196ea60a73 hw/smbios: Fix core count in type4
> > 7298fd7de5 hw/smbios: Fix thread count in type4
> > d79a284a44 hw/smbios: Fix smbios_smp_sockets caculation  
> 
> plus this one:
> 
> a1d027be95 machine: Add helpers to get cores/threads per socket
> 
> /mjt
> 

just to note: v4 was what got merged eventually
https://www.mail-archive.com/qemu-devel@nongnu.org/msg972625.html

as for stable, I guess dies/clusters aren't used in production
(based on lack of bug reports/complaints).
It's not worth of back-porting if it's too complex,
but if it's clean cherry-picks it might help folks who use
downstream (it's easier for downstream to pickup fixes from
stable branch) to test this code path.


