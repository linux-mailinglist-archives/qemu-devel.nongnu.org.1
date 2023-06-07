Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 4A5AF7265D5
	for <lists+qemu-devel@lfdr.de>; Wed,  7 Jun 2023 18:26:16 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1q6vxq-00009U-N6; Wed, 07 Jun 2023 12:24:50 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1q6vxo-00008J-Cq
 for qemu-devel@nongnu.org; Wed, 07 Jun 2023 12:24:48 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1q6vxm-0006lP-TK
 for qemu-devel@nongnu.org; Wed, 07 Jun 2023 12:24:48 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1686155085;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=wstVw8tmycB7bkh1WRfMZZR7YZOJCpNuIcnoKyrIw54=;
 b=hgoSHpiIM4vbRqYo2Rz6FbCGOFzjUz4bMmVXcWqMoHrZLIQ+EpGALt7cvV7cxbVQ6YQM15
 q+G581l08l6tdvcpo5OcrHf+4lB+C1gSfFevZOb3ycVlYiqMj8dyILfahC4DH+y20vEYlc
 NpscxnzoVPl8e/AvZaQcwufANqOfX3E=
Received: from mail-qv1-f72.google.com (mail-qv1-f72.google.com
 [209.85.219.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-508-P69DU4yxMnik3ETw18uRZQ-1; Wed, 07 Jun 2023 12:24:44 -0400
X-MC-Unique: P69DU4yxMnik3ETw18uRZQ-1
Received: by mail-qv1-f72.google.com with SMTP id
 6a1803df08f44-62b67ff6943so3595726d6.0
 for <qemu-devel@nongnu.org>; Wed, 07 Jun 2023 09:24:44 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1686155083; x=1688747083;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=wstVw8tmycB7bkh1WRfMZZR7YZOJCpNuIcnoKyrIw54=;
 b=VmPj3ayYNLApkQswlES73ImcPy25rOCRXg+akUfcsLBlKBBOlO/Zd5tk7+EWjmJl3j
 NeLAFOb6hflXHIn0xb6mzkhGwj/QJbgXUFopsHRy1wUPgMihIwZJvgJg7y67rxXUn4qH
 okRY6zAqs4dvZBHXHTWtgj6l5rGYQFtfa3ZzmY8pEWgIPTm+5HHtu7GG7DNB0CgXATRy
 zhn/KwK/fdB3BTUg7S9YYsJuN8WpdT1LSeyZ2lOhHmw1LKlEjo0l7X2mPXXRUGveWPpW
 RCPnwIdwW7o2yFjdfRT/+cMTQufQqLTgJJmZj4LHR8THkkq9HgYOtOG6rGX/YbBHSYRk
 HPXg==
X-Gm-Message-State: AC+VfDwwWDoy1N1fqE9cpj26gxxd+Ua+5eGtEqw3yT7cITN0hJeus+Rt
 w1sHqxSWy8IqRpi7ilJRs+OdprmZr78I5ufWiSncxuOYLrySsmveenlzinS3HzSEshESkb+zTxX
 quW3Qc9eU1ePMeMg=
X-Received: by 2002:a05:6214:c6d:b0:616:870c:96b8 with SMTP id
 t13-20020a0562140c6d00b00616870c96b8mr6579712qvj.3.1686155083707; 
 Wed, 07 Jun 2023 09:24:43 -0700 (PDT)
X-Google-Smtp-Source: ACHHUZ4fQ9sVs0UkCSkzBQrKaFuMdM8SYdiBQqpH5w6qlra3F4vMiL6xGtaD89AO8U24asd8Ld0Sjw==
X-Received: by 2002:a05:6214:c6d:b0:616:870c:96b8 with SMTP id
 t13-20020a0562140c6d00b00616870c96b8mr6579688qvj.3.1686155083431; 
 Wed, 07 Jun 2023 09:24:43 -0700 (PDT)
Received: from x1n (cpe5c7695f3aee0-cm5c7695f3aede.cpe.net.cable.rogers.com.
 [99.254.144.39]) by smtp.gmail.com with ESMTPSA id
 x14-20020a0ce0ce000000b00605f796d30esm29008qvk.51.2023.06.07.09.24.42
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 07 Jun 2023 09:24:42 -0700 (PDT)
Date: Wed, 7 Jun 2023 12:24:41 -0400
From: Peter Xu <peterx@redhat.com>
To: Fabiano Rosas <farosas@suse.de>
Cc: qemu-devel@nongnu.org, Peter Maydell <peter.maydell@linaro.org>,
 Juan Quintela <quintela@redhat.com>,
 Jiang Jiacheng <jiangjiacheng@huawei.com>,
 Leonardo Bras <leobras@redhat.com>
Subject: Re: [PATCH v2 0/3] migration: Fix multifd cancel test
Message-ID: <ZICvSTVotKRtHq3P@x1n>
References: <20230607161306.31425-1-farosas@suse.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20230607161306.31425-1-farosas@suse.de>
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

On Wed, Jun 07, 2023 at 01:13:03PM -0300, Fabiano Rosas wrote:
> Fabiano Rosas (3):
>   migration/multifd: Rename threadinfo.c functions
>   migration/multifd: Protect accesses to migration_threads
>   tests/qtest: Re-enable multifd cancel test

Reviewed-by: Peter Xu <peterx@redhat.com>

-- 
Peter Xu


