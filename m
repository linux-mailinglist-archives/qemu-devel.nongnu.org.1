Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 4624E7CF715
	for <lists+qemu-devel@lfdr.de>; Thu, 19 Oct 2023 13:37:46 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qtRKi-0006tT-RA; Thu, 19 Oct 2023 07:36:56 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <quintela@redhat.com>)
 id 1qtRKf-0006nq-QY
 for qemu-devel@nongnu.org; Thu, 19 Oct 2023 07:36:53 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <quintela@redhat.com>)
 id 1qtRKe-0005wV-0a
 for qemu-devel@nongnu.org; Thu, 19 Oct 2023 07:36:53 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1697715410;
 h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:in-reply-to:in-reply-to:  references:references;
 bh=5Vomw6oSZb0h14ocpK3CawFWyA0t+txLs7Ap8HSJjCA=;
 b=goNnxshm4cE2CQY2qmNPGjOTa9CTZrryZhnwgn8XY5rmQjOVu32t6kx0j3QE/57akvUkHO
 zFkhZjIbSaKQIJDPDrJVktjIBOuZuQACeDn7PaIAsLsr7A1olW4B0XIHSCsv55LdiFJKZo
 KrKJHGeQmuOIOfLvU55ivKqFwaAGSGM=
Received: from mail-lj1-f199.google.com (mail-lj1-f199.google.com
 [209.85.208.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-532-uIV1GM_-NoqcQjf0MiYmVA-1; Thu, 19 Oct 2023 07:36:43 -0400
X-MC-Unique: uIV1GM_-NoqcQjf0MiYmVA-1
Received: by mail-lj1-f199.google.com with SMTP id
 38308e7fff4ca-2c50ef18b04so54957791fa.1
 for <qemu-devel@nongnu.org>; Thu, 19 Oct 2023 04:36:43 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1697715402; x=1698320202;
 h=mime-version:message-id:date:reply-to:user-agent:references
 :in-reply-to:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=5Vomw6oSZb0h14ocpK3CawFWyA0t+txLs7Ap8HSJjCA=;
 b=jzGKdJQkKJxA3nh+RCPBIgRbdonCCkwRo/qOIuKsvCH7pJ+KcJqwPk97lZAh65F1BA
 ZVCBxQJmYKJogrvLp5PYZ8ZFL6TqsvNlJR0BQuZ1qVlzsL9fKnxwnXLlyxtZJmQSHZWn
 WW9gHqfAAxuIPpCc0pFlnVxQ/rLd949auFW3AwxM4r8mvcUmhhJUZ3fQ/eEp0JiSFkDu
 qrQvokKj+njQhKP5VJhrz5dCQ+GDgpeeFsvtnjyXEyfNiGLrn5NOn5LAK9X9zVNuptVl
 6omW9g00y3hgci1rygZ56b5/Qei3QnND1uYCcg5y+d58pBljoBpe+/d14k0XJNBoXAAY
 amFQ==
X-Gm-Message-State: AOJu0Yz6Nn2FBwrHJhsUitphM8IVUnMwSAEAFRKJA4uHg7T9v+WAw28O
 lxNLdf7co+moSV3RmmJ6PAaJBfen7gTIWvt6HW9FkvNa4nOHS/90gdpjvt8PMeTt5yGYx74i0On
 gdnWhlB9L/Tr79a8=
X-Received: by 2002:a05:651c:d0:b0:2c4:feef:84d with SMTP id
 16-20020a05651c00d000b002c4feef084dmr1297974ljr.43.1697715402406; 
 Thu, 19 Oct 2023 04:36:42 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFzudqCYA5dRBkaxqe3MxoAcnePOofcq49HX7l4oiLOMyb5cxLK4gulhDWMJRCRwNVoviiV/Q==
X-Received: by 2002:a05:651c:d0:b0:2c4:feef:84d with SMTP id
 16-20020a05651c00d000b002c4feef084dmr1297956ljr.43.1697715401977; 
 Thu, 19 Oct 2023 04:36:41 -0700 (PDT)
Received: from redhat.com (static-151-150-85-188.ipcom.comunitel.net.
 [188.85.150.151]) by smtp.gmail.com with ESMTPSA id
 x19-20020a05600c421300b003fc16ee2864sm4105400wmh.48.2023.10.19.04.36.41
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 19 Oct 2023 04:36:41 -0700 (PDT)
From: Juan Quintela <quintela@redhat.com>
To: Yuan Liu <yuan1.liu@intel.com>
Cc: peterx@redhat.com,  farosas@suse.de,  leobras@redhat.com,
 qemu-devel@nongnu.org,  nanhai.zou@intel.com
Subject: Re: [PATCH 5/5] migration iaa-compress: Implement IAA compression
In-Reply-To: <20231018221224.599065-6-yuan1.liu@intel.com> (Yuan Liu's message
 of "Thu, 19 Oct 2023 06:12:24 +0800")
References: <20231018221224.599065-1-yuan1.liu@intel.com>
 <20231018221224.599065-6-yuan1.liu@intel.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.3 (gnu/linux)
Date: Thu, 19 Oct 2023 13:36:40 +0200
Message-ID: <87h6mm6dyv.fsf@secure.mitica>
MIME-Version: 1.0
Content-Type: text/plain
Received-SPF: pass client-ip=170.10.133.124; envelope-from=quintela@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
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
Reply-To: quintela@redhat.com
Errors-To: qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org
Sender: qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org

Yuan Liu <yuan1.liu@intel.com> wrote:
> Implement the functions of IAA for data compression and decompression.
> The implementation uses non-blocking job submission and polling to check
> the job completion status to reduce IAA's overhead in the live migration
> process.
>
> Signed-off-by: Yuan Liu <yuan1.liu@intel.com>
> Reviewed-by: Nanhai Zou <nanhai.zou@intel.com>


> +static void process_completed_job(IaaJob *job, send_iaa_data send_page)
> +{
> +    if (job->is_compression) {
> +        send_page(job->param.comp.block, job->param.comp.offset,
> +                  job->out_buf, job->out_len, job->param.comp.result);
> +    } else {
> +        assert(job->out_len == qemu_target_page_size());
> +        memcpy(job->param.decomp.host, job->out_buf, job->out_len);
> +    }
> +    put_job(job);
> +}

Shouldn't it be easier to add a helper to job struct and not having that
if here?  I.e. become:

static void process_completed_job(IaaJob *job, send_iaa_data send_page)
{
    job->completed(job, send_page);
    put_job(job);
}

And do proper initializations.  You can even put the send_page callback
in the job struct.

> +static qpl_status check_job_status(IaaJob *job, bool block)
> +{
> +    qpl_status status;
> +    qpl_job *qpl = job->qpl;
> +
> +    status = block ? qpl_wait_job(qpl) : qpl_check_job(qpl);
> +    if (status == QPL_STS_OK) {
> +        job->out_len = qpl->total_out;
> +        if (job->is_compression) {
> +            job->param.comp.result = RES_COMPRESS;
> +            /* if no compression benefit, send a normal page for migration */
> +            if (job->out_len == qemu_target_page_size()) {
> +                iaa_comp_param *param = &(job->param.comp);
> +                memcpy(job->out_buf, (param->block->host + param->offset),
> +                       job->out_len);
> +                job->param.comp.result = RES_NONE;
> +            }
> +        }
> +    } else if (status == QPL_STS_MORE_OUTPUT_NEEDED) {
> +        if (job->is_compression) {
> +            /*
> +             * if the compressed data is larger than the original data, send a
> +             * normal page for migration, in this case, IAA has copied the
> +             * original data to job->out_buf automatically.
> +             */
> +            job->out_len = qemu_target_page_size();
> +            job->param.comp.result = RES_NONE;
> +            status = QPL_STS_OK;
> +        }
> +    }

Again, this function for decompression becomes a single line:

    status = block ? qpl_wait_job(qpl) : qpl_check_job(qpl);
    if (status == QPL_STS_OK) {
        job->out_len = qpl->total_out;
    }

Wait complicate it?

> +static void check_polling_jobs(send_iaa_data send_page)
> +{
> +    IaaJob *job, *job_next;
> +    qpl_status status;
> +
> +    QSIMPLEQ_FOREACH_SAFE(job, &polling_queue, entry, job_next) {
> +        status = check_job_status(job, false);
> +        if (status == QPL_STS_OK) { /* job has done */
> +            process_completed_job(job, send_page);
> +            QSIMPLEQ_REMOVE_HEAD(&polling_queue, entry);
> +        } else if (status == QPL_STS_BEING_PROCESSED) { /* job is running */
> +            break;
> +        } else {
> +            abort();

Not even printing an error message?

The two callers of check_polling_jobs() can return an error, so no
reason to abort() here.

Later, Juan.


