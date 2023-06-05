Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 8B98F722ED9
	for <lists+qemu-devel@lfdr.de>; Mon,  5 Jun 2023 20:40:58 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1q6F7K-0000kb-Bz; Mon, 05 Jun 2023 14:39:46 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1q6F7I-0000kL-9Q
 for qemu-devel@nongnu.org; Mon, 05 Jun 2023 14:39:44 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1q6F7G-0002Gx-T1
 for qemu-devel@nongnu.org; Mon, 05 Jun 2023 14:39:44 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1685990381;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=Lu5DY0fCRHzY/RGHPGA4dafNcZDM9ldEfBTk9TCfcS4=;
 b=Jo2lydwIdqxqayxd8UX+mT+S6H9baJ8k94ndXdMSg2qUsmafGm1SNnkqi4djZyuEPmEtX8
 9L54ojQehK2+9jgBbrKvZMxIeLyYyuM8lxpkb6JTyGJLfVYTGLJYaq/C70g1Yf4/MgqJV2
 JyP9IWcYJG/rXAju7/oMfpNortZtJ9E=
Received: from mail-qk1-f197.google.com (mail-qk1-f197.google.com
 [209.85.222.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-532-I4nWZTZlPZKdYsZmRI14RA-1; Mon, 05 Jun 2023 14:39:38 -0400
X-MC-Unique: I4nWZTZlPZKdYsZmRI14RA-1
Received: by mail-qk1-f197.google.com with SMTP id
 af79cd13be357-75b337f2504so101211185a.0
 for <qemu-devel@nongnu.org>; Mon, 05 Jun 2023 11:39:38 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1685990377; x=1688582377;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=Lu5DY0fCRHzY/RGHPGA4dafNcZDM9ldEfBTk9TCfcS4=;
 b=e8K5P2oQ9DICSZ8zG23tj4zFRk1t40/IqIzbh2wDk6fEng5kIz7VmLkdMx+EIhcHDd
 Ui9bYwnw7JdPQwpkwkO1edHg2kyFaRh4Z0c/72rgwex7lxPROumnkQhiw1KycaCBPcRs
 KZjtcLT5WXfIk+NkWEEs7sLnhzTG5eWiTPf21ZX4fEvfLlJM7SHfdRD5XxrzYFaZh1j4
 RD9DO0cwEZ9F1GyZLZoGsW5k3DPYfjQCGtGl8oxs/lmMYSnmesEtEAq7fyliqgxmKjdJ
 L8KhAA1+rQG/o2gckLLDwqka1v6HZunKobwqDFVrlE8HL8q0p+SFwEFSJFGwR3J1T8ve
 dyrw==
X-Gm-Message-State: AC+VfDxitFoHhSjxX3mEDdwP+MTFainXyrsSn/hEo6jm5XMLoMCuFEus
 xrppjfRzwg98Ai5XEB1GZ/BAv+hGf8JVn5JGAEH7EKG9sqHOZlhnNbS+PDeAE+lWqXvMBLlHQJj
 l6tA/+pEbxZktRtk=
X-Received: by 2002:a05:6214:5087:b0:625:86ed:8ab4 with SMTP id
 kk7-20020a056214508700b0062586ed8ab4mr23784175qvb.3.1685990377741; 
 Mon, 05 Jun 2023 11:39:37 -0700 (PDT)
X-Google-Smtp-Source: ACHHUZ58fOt7YpPZdJpOnAyziftJvgpqKsJR2XDIDj7YIsuxIrNIqoGV/aOby1Dys6RXK8wU2B4Z5g==
X-Received: by 2002:a05:6214:5087:b0:625:86ed:8ab4 with SMTP id
 kk7-20020a056214508700b0062586ed8ab4mr23784156qvb.3.1685990377466; 
 Mon, 05 Jun 2023 11:39:37 -0700 (PDT)
Received: from x1n (cpe5c7695f3aee0-cm5c7695f3aede.cpe.net.cable.rogers.com.
 [99.254.144.39]) by smtp.gmail.com with ESMTPSA id
 dy16-20020ad44e90000000b006263afa6ab9sm4741508qvb.144.2023.06.05.11.39.36
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 05 Jun 2023 11:39:36 -0700 (PDT)
Date: Mon, 5 Jun 2023 14:39:35 -0400
From: Peter Xu <peterx@redhat.com>
To: Zhenzhong Duan <zhenzhong.duan@intel.com>
Cc: qemu-devel@nongnu.org, mst@redhat.com, jasowang@redhat.com,
 pbonzini@redhat.com, richard.henderson@linaro.org,
 eduardo@habkost.net, marcel.apfelbaum@gmail.com,
 alex.williamson@redhat.com, clg@redhat.com, david@redhat.com,
 philmd@linaro.org, kwankhede@nvidia.com, cjia@nvidia.com,
 yi.l.liu@intel.com, chao.p.peng@intel.com
Subject: Re: [PATCH v2 1/4] util: Add iova_tree_foreach_range_data
Message-ID: <ZH4r5zjs9+PBb3jQ@x1n>
References: <20230601063320.139308-1-zhenzhong.duan@intel.com>
 <20230601063320.139308-2-zhenzhong.duan@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20230601063320.139308-2-zhenzhong.duan@intel.com>
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

On Thu, Jun 01, 2023 at 02:33:17PM +0800, Zhenzhong Duan wrote:
> This function is a variant of iova_tree_foreach and support tranversing
> a range to trigger callback with a private data.
> 
> Signed-off-by: Zhenzhong Duan <zhenzhong.duan@intel.com>

Reviewed-by: Peter Xu <peterx@redhat.com>

-- 
Peter Xu


