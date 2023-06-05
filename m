Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 5D39E722E82
	for <lists+qemu-devel@lfdr.de>; Mon,  5 Jun 2023 20:20:22 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1q6Emp-0005Hd-Jl; Mon, 05 Jun 2023 14:18:35 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1q6Emn-0005HB-Ej
 for qemu-devel@nongnu.org; Mon, 05 Jun 2023 14:18:33 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1q6Eml-0006Ao-Ui
 for qemu-devel@nongnu.org; Mon, 05 Jun 2023 14:18:33 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1685989111;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=yvV7H8tTB8o30Qi3mp/nI+YOqFHI8q0pDZQv7Ddb/7Y=;
 b=THpX81PeV7vC4ImVKFz0hhBtBjvUs9MsZKjGR/EBJtCfKlyVvdEOEJGG9hYoIJ3MT6homM
 9bKWOrdi7mR4hH7o3pXoWytC3Ykfs6ByNUYVoZBIgodBISMTRTzEtwwNOdS0JzmlkuN8qx
 SKZCQnTKDQ5KKCcf0NVgRANh66rcXEk=
Received: from mail-qk1-f199.google.com (mail-qk1-f199.google.com
 [209.85.222.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-625-tiXv_HqDNL6UH3zGaaYDeQ-1; Mon, 05 Jun 2023 14:18:29 -0400
X-MC-Unique: tiXv_HqDNL6UH3zGaaYDeQ-1
Received: by mail-qk1-f199.google.com with SMTP id
 af79cd13be357-74faf5008bbso96434985a.0
 for <qemu-devel@nongnu.org>; Mon, 05 Jun 2023 11:18:29 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1685989109; x=1688581109;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=yvV7H8tTB8o30Qi3mp/nI+YOqFHI8q0pDZQv7Ddb/7Y=;
 b=Vx54Klsko7EogHTJZQRNq/LDDNCvyijeDM5YQDH4z18Htei/pw6SB0Ugd/UAGfcMXN
 GSEdAl0oR7vaKPMOkhwZahHyTp060GG7H3Ap+5XAMSq79BrvsBZiDpxMLHi3YEAzgbkz
 imj+IRhpyOw0rBx17ajBejSi4MtOaQdSfeD5Nw1dVhL1iRzC6t1qrU6Fza2zeN7sfkAF
 2/+ZlY2dH4DKqLBNdht3fsCnWvrzjx2IrMDqR/06RWfLDVQOFXzpV2yCtkzEf+oDmyg3
 xSzmstXe05AMe7GDWcuhRu+mE2Xm1bkXkY+MVCFi/KZClJiCabaHJG46TSNRcJ+zExEs
 vLyw==
X-Gm-Message-State: AC+VfDzb4DzBeB8mlOhu6uu2rBYWA4Lte3+ot2SMu6GyUeim5g3cs+/y
 bCvIeHYK9G56Im+Doif+xnBGGLckq8Q6r/pXMF7WrBbwc7Vdc29AnSrhGpDV77PlqcvaV+HU/9l
 eC4qF+lSjMZxFwxw=
X-Received: by 2002:a05:620a:6085:b0:75e:bd15:d95a with SMTP id
 dx5-20020a05620a608500b0075ebd15d95amr2803021qkb.6.1685989109255; 
 Mon, 05 Jun 2023 11:18:29 -0700 (PDT)
X-Google-Smtp-Source: ACHHUZ5Jyx9oPwc0kL3ufEV8FzmKMGx72d84obfHsAEhUyjZV4Nc54+/HNXu5R4oW6EUAAaoDoag/g==
X-Received: by 2002:a05:620a:6085:b0:75e:bd15:d95a with SMTP id
 dx5-20020a05620a608500b0075ebd15d95amr2802992qkb.6.1685989108884; 
 Mon, 05 Jun 2023 11:18:28 -0700 (PDT)
Received: from x1n (cpe5c7695f3aee0-cm5c7695f3aede.cpe.net.cable.rogers.com.
 [99.254.144.39]) by smtp.gmail.com with ESMTPSA id
 h5-20020a37de05000000b0075e70bf3cffsm1480012qkj.74.2023.06.05.11.18.27
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 05 Jun 2023 11:18:28 -0700 (PDT)
Date: Mon, 5 Jun 2023 14:18:26 -0400
From: Peter Xu <peterx@redhat.com>
To: Juan Quintela <quintela@redhat.com>
Cc: qemu-devel@nongnu.org, Leonardo Bras <leobras@redhat.com>,
 Hailiang Zhang <zhanghailiang@xfusion.com>,
 Fiona Ebner <f.ebner@proxmox.com>,
 Stefan Hajnoczi <stefanha@redhat.com>, qemu-block@nongnu.org,
 Fam Zheng <fam@euphon.net>
Subject: Re: [PATCH v2 04/20] qemu-file: We only call qemu_file_transferred_*
 on the sending side
Message-ID: <ZH4m8nUAEfZglPLD@x1n>
References: <20230530183941.7223-1-quintela@redhat.com>
 <20230530183941.7223-5-quintela@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20230530183941.7223-5-quintela@redhat.com>
Received-SPF: pass client-ip=170.10.129.124; envelope-from=peterx@redhat.com;
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

On Tue, May 30, 2023 at 08:39:25PM +0200, Juan Quintela wrote:
> Remove the increase in qemu_file_fill_buffer() and add asserts to
> qemu_file_transferred* functions.
> 
> Signed-off-by: Juan Quintela <quintela@redhat.com>

The read side accounting does look a bit weird and never caught my notice..

Maybe worth also touching the document of QEMUFile::total_transferred to
clarify what it accounts?

Reviewed-by: Peter Xu <peterx@redhat.com>

Though when I'm looking at the counters (didn't follow every single recent
patch on this..), I found that now reading transferred value is actually
more expensive - qemu_file_transferred() needs flushing, even if for the
fast version, qemu_file_transferred_fast() loops over all possible iovs,
which can be as large as MAX_IOV_SIZE==64.

To be explicit, I _think_ for each guest page we now need to flush...

  ram_save_iterate
    migration_rate_exceeded
      migration_transferred_bytes
        qemu_file_transferred

I hope I'm wrong..

Does it mean that perhaps we simply need "sent and put into send buffer"
more than "what really got transferred"?  So I start to wonder what's the
origianl purpose of this change, and which one is better..

-- 
Peter Xu


