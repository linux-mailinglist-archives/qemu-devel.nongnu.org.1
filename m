Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id AF67074F38B
	for <lists+qemu-devel@lfdr.de>; Tue, 11 Jul 2023 17:33:19 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qJFLB-00052q-9V; Tue, 11 Jul 2023 11:31:49 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <david@redhat.com>) id 1qJFL8-00052M-0H
 for qemu-devel@nongnu.org; Tue, 11 Jul 2023 11:31:46 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <david@redhat.com>) id 1qJFL6-0004xC-N4
 for qemu-devel@nongnu.org; Tue, 11 Jul 2023 11:31:45 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1689089503;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=mVcqr+vjtLmlApNnpqx2TXvOgEK8lOceCz3+QYiBkGw=;
 b=IyjNt4KCPKjOA6/+gAl+RViBFoiLMiJugLatjh3u6cMV5QNbqbVmyh6DIXxXf2WhERqbvI
 pQHIrlLxXX1MaiOaF17w7rDOmJe2gzFiW9u6kE4VWe64Uao3uymqiaLJ6bk9JqrfBXfMdW
 +CJ8sQiojnSvffvBz1dggETzNLqeNYk=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-19-oBwighddMySqtbQ-tKdOeQ-1; Tue, 11 Jul 2023 11:31:41 -0400
X-MC-Unique: oBwighddMySqtbQ-tKdOeQ-1
Received: by mail-wr1-f69.google.com with SMTP id
 ffacd0b85a97d-31437f02985so3604329f8f.0
 for <qemu-devel@nongnu.org>; Tue, 11 Jul 2023 08:31:40 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1689089499; x=1691681499;
 h=content-transfer-encoding:in-reply-to:organization:from:references
 :cc:to:content-language:subject:user-agent:mime-version:date
 :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=mVcqr+vjtLmlApNnpqx2TXvOgEK8lOceCz3+QYiBkGw=;
 b=NxWpwfIsYpD7WsMBlnPr1FOKorm00XV21fEh78AqY4LieX0qvaT3K1lMRawHj3SFyh
 kjZqXkykoL49GpN3KNJLd+R+bj9hCa+CVBwz6NDMaDJY1o1f31ioVpyFwM3CTqCudehR
 kSMxNPvVc+mGtPBlgYB9SPc3ijUrjDFAYLWphPOBMX7s9DvQaFvRMDfitNdMfIMAPSzR
 bxZ7gU3b7yUcj9fxa9SfIDdg648hWSKx/ozEYp4+zinKtZRTXTinex/O1QGJf2XpEnco
 IVfd2C9uTaH1XAcS6bGMm/5jVTulWb1oo4aZAVzajYgYGB3+1xnwZyeIfCVfac4OFh/z
 t9yQ==
X-Gm-Message-State: ABy/qLYfu2KqBWGIiGy7OuKfUodasavZDy5PxLxGUw0uhgZRz2k/vMQ4
 YNah4aoMsrpCVrUrHtWK/+Ydz2eAWyQyp+gTnnwyJRjO7b/s3+G3v9BlTnDTn/PnK0E7NMRW8DY
 ZTF/5hRcYHsJOvpg=
X-Received: by 2002:adf:e310:0:b0:313:f371:aede with SMTP id
 b16-20020adfe310000000b00313f371aedemr16289366wrj.1.1689089499422; 
 Tue, 11 Jul 2023 08:31:39 -0700 (PDT)
X-Google-Smtp-Source: APBJJlHbRMVHslKfZNMBA+Xx4K8ZCz1t1XPEtAlshrkp8jx9XMGtbOm3l29l+tMEo/0rBAEJOdG4+g==
X-Received: by 2002:adf:e310:0:b0:313:f371:aede with SMTP id
 b16-20020adfe310000000b00313f371aedemr16289342wrj.1.1689089499099; 
 Tue, 11 Jul 2023 08:31:39 -0700 (PDT)
Received: from ?IPV6:2003:cb:c745:4000:13ad:ed64:37e6:115d?
 (p200300cbc745400013aded6437e6115d.dip0.t-ipconnect.de.
 [2003:cb:c745:4000:13ad:ed64:37e6:115d])
 by smtp.gmail.com with ESMTPSA id
 w13-20020a5d4b4d000000b003143765e207sm2516288wrs.49.2023.07.11.08.31.38
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 11 Jul 2023 08:31:38 -0700 (PDT)
Message-ID: <b44555cd-5c6d-3736-8e7a-cdd6acf612b7@redhat.com>
Date: Tue, 11 Jul 2023 17:31:37 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.12.0
Subject: Re: [PATCH v3 0/7] virtio-mem: Device unplug support
Content-Language: en-US
To: Mario Casquero <mcasquer@redhat.com>
Cc: qemu-devel@nongnu.org, Peter Maydell <peter.maydell@linaro.org>,
 Paolo Bonzini <pbonzini@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Eduardo Habkost <eduardo@habkost.net>, "Michael S. Tsirkin"
 <mst@redhat.com>, Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 Igor Mammedov <imammedo@redhat.com>, qemu-arm@nongnu.org,
 Gavin Shan <gshan@redhat.com>
References: <20230710100714.228867-1-david@redhat.com>
 <CAMXpfWsD9_UvB6cez9oKZt9PREkVALhX0sQ=Qyok78juME78jQ@mail.gmail.com>
From: David Hildenbrand <david@redhat.com>
Organization: Red Hat
In-Reply-To: <CAMXpfWsD9_UvB6cez9oKZt9PREkVALhX0sQ=Qyok78juME78jQ@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=170.10.129.124; envelope-from=david@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 NICE_REPLY_A=-0.089, RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001,
 RCVD_IN_MSPIKE_WL=0.001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
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

On 11.07.23 16:19, Mario Casquero wrote:
> Tested-by: Mario Casquero<mcasquer@redhat.com>

Thanks a lot Mario!

-- 
Cheers,

David / dhildenb


