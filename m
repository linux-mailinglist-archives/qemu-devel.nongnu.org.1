Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id B6053B8FC5D
	for <lists+qemu-devel@lfdr.de>; Mon, 22 Sep 2025 11:35:45 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1v0cus-0003p3-1R; Mon, 22 Sep 2025 05:33:02 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1v0ct9-0003Ii-OX
 for qemu-devel@nongnu.org; Mon, 22 Sep 2025 05:31:17 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1v0csz-0007py-27
 for qemu-devel@nongnu.org; Mon, 22 Sep 2025 05:31:15 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1758533460;
 h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:in-reply-to:in-reply-to:  references:references;
 bh=lSLRXcKP7rOwAdM0iz7/K5Bp37fleJW0KIwsEONuJH8=;
 b=Nb2iUQheFgMDa08VMmf/nB82nZiFaLvTOvhA1dNY8Y9YZrltTJrPqmrBWGJxjeGC+ZuDAM
 mp6dH57k5hQRoi/5zE1ueYKrR6+FBsMSTxhh7CL3cVOYAsqTjUAfcNKY6+8B63WmwEdMFh
 fv8TgfY1wLoADnrNjY1JK5tLeyV+6Fo=
Received: from mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-643-uiWBqBVjOP6z3UUk-AtYjg-1; Mon,
 22 Sep 2025 05:30:56 -0400
X-MC-Unique: uiWBqBVjOP6z3UUk-AtYjg-1
X-Mimecast-MFC-AGG-ID: uiWBqBVjOP6z3UUk-AtYjg_1758533455
Received: from mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 1C37C1956054; Mon, 22 Sep 2025 09:30:55 +0000 (UTC)
Received: from redhat.com (unknown [10.42.28.69])
 by mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 288943000198; Mon, 22 Sep 2025 09:30:51 +0000 (UTC)
Date: Mon, 22 Sep 2025 10:30:48 +0100
From: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
To: Gustavo Romero <gustavo.romero@linaro.org>
Cc: qemu-devel@nongnu.org, alex.bennee@linaro.org, thuth@redhat.com,
 qemu-arm@nongnu.org, manos.pitsidianakis@linaro.org,
 peter.maydell@linaro.org
Subject: Re: [PATCH v3 3/4] tests/functional: Adapt reverse_debugging to run
 w/o Avocado
Message-ID: <aNEXSCyXi_5NLs2C@redhat.com>
References: <20250922054351.14289-1-gustavo.romero@linaro.org>
 <20250922054351.14289-4-gustavo.romero@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20250922054351.14289-4-gustavo.romero@linaro.org>
User-Agent: Mutt/2.2.14 (2025-02-20)
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.4
Received-SPF: pass client-ip=170.10.129.124; envelope-from=berrange@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -25
X-Spam_score: -2.6
X-Spam_bar: --
X-Spam_report: (-2.6 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.442,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=-0.01, RCVD_IN_MSPIKE_WL=-0.01,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
 SPF_HELO_PASS=-0.001,
 T_SPF_TEMPERROR=0.01 autolearn=unavailable autolearn_force=no
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
Reply-To: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
Errors-To: qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org
Sender: qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org

On Mon, Sep 22, 2025 at 05:43:50AM +0000, Gustavo Romero wrote:
> This commit removes Avocado as a dependency for running the
> reverse_debugging test.
> 
> The main benefit, beyond eliminating an extra dependency, is that there
> is no longer any need to handle GDB packets manually. This removes the
> need for ad-hoc functions dealing with endianness and arch-specific
> register numbers, making the test easier to read. The timeout variable
> is also removed, since Meson now manages timeouts automatically.
> 
> reverse_debugging now uses the pygdbmi module to interact with GDB, if
> it's available in the test environment, otherwise the test is skipped.
> GDB is detect via the QEMU_TEST_GDB env. variable.
> 
> This commit also significantly improves the output for the test and
> now prints all the GDB commands used in sequence. It also adds
> some clarifications to existing comments, for example, clarifying that
> once the replay-break is reached, a SIGINT is captured in GDB.
> 
> reverse_debugging is kept "skipped" for aarch64, ppc64, and x86_64, so
> won't run unless QEMU_TEST_FLAKY_TESTS=1 is set in the test environment,
> before running 'make check-functional' or 'meson test [...]'.
> 
> Signed-off-by: Gustavo Romero <gustavo.romero@linaro.org>
> ---
>  tests/functional/reverse_debugging.py | 308 ++++++++++++++++----------
>  1 file changed, 188 insertions(+), 120 deletions(-)
> 
> diff --git a/tests/functional/reverse_debugging.py b/tests/functional/reverse_debugging.py
> index f9a1d395f1..38161beab8 100644
> --- a/tests/functional/reverse_debugging.py
> +++ b/tests/functional/reverse_debugging.py
> @@ -1,21 +1,94 @@
> -# Reverse debugging test
> -#
>  # SPDX-License-Identifier: GPL-2.0-or-later
>  #
> +# Reverse debugging test
> +#
>  # Copyright (c) 2020 ISP RAS
> +# Copyright (c) 2025 Linaro Limited
>  #
>  # Author:
>  #  Pavel Dovgalyuk <Pavel.Dovgalyuk@ispras.ru>
> +#  Gustavo Romero <gustavo.romero@linaro.org> (Run without Avocado)
>  #
>  # This work is licensed under the terms of the GNU GPL, version 2 or
>  # later.  See the COPYING file in the top-level directory.
> -import os
> +
>  import logging
> +import os
> +import re
> +import subprocess
> +from pygdbmi.gdbcontroller import GdbController
> +from pygdbmi.constants import GdbTimeoutError
> +
>  
>  from qemu_test import LinuxKernelTest, get_qemu_img
>  from qemu_test.ports import Ports
>  
>  
> +class GDB:
> +    def __init__(self, gdb_path, echo=True, suffix='# ', prompt="$ "):
> +        gdb_cmd = [gdb_path, "-q", "--interpreter=mi2"]
> +        self.gdbmi = GdbController(gdb_cmd)
> +        self.echo = echo
> +        self.suffix = suffix
> +        self.prompt = prompt
> +
> +
> +    def get_payload(self, response, kind):
> +        output = []
> +        for o in response:
> +            # Unpack payloads of the same type.
> +            _type, _, payload, *_ = o.values()
> +            if _type == kind:
> +                output += [payload]
> +
> +        # Some output lines do not end with \n but begin with it,
> +        # so remove the leading \n and merge them with the next line
> +        # that ends with \n.
> +        lines = [line.lstrip('\n') for line in output]
> +        lines = "".join(lines)
> +        lines = lines.splitlines(keepends=True)
> +
> +        return lines
> +
> +
> +    def cli(self, cmd, timeout=4.0):
> +        self.response = self.gdbmi.write(cmd, timeout_sec=timeout)
> +        self.cmd_output = self.get_payload(self.response, "console")
> +        if self.echo:
> +            print(self.suffix + self.prompt + cmd)
> +
> +            if len(self.cmd_output) > 0:
> +                cmd_output = self.suffix.join(self.cmd_output)
> +                print(self.suffix + cmd_output, end="")
> +
> +        return self
> +
> +
> +    def get_addr(self):
> +        pattern = r"0x[0-9A-Fa-f]+"
> +        cmd_output = "".join(self.cmd_output)
> +        match = re.search(pattern, cmd_output)
> +
> +        return int(match[0], 16) if match else None
> +
> +
> +    def get_log(self):
> +        r = self.get_payload(self.response, kind="log")
> +        r = "".join(r)
> +
> +        return r
> +
> +
> +    def get_console(self):
> +        r = "".join(self.cmd_output)
> +
> +        return r
> +
> +
> +    def exit(self):
> +        self.gdbmi.exit()
> +

Can you put this in tests/functional/qemu_test/gdb.py as it is
generic logic not tied to this specific test.

>  class ReverseDebugging(LinuxKernelTest):
>      """
>      Test GDB reverse debugging commands: reverse step and reverse continue.
> @@ -28,21 +101,17 @@ class ReverseDebugging(LinuxKernelTest):
>      that the execution is stopped at the last of them.
>      """
>  
> -    timeout = 10
>      STEPS = 10
> -    endian_is_le = True
>  
>      def run_vm(self, record, shift, args, replay_path, image_path, port):
> -        from avocado.utils import datadrainer
> -
>          logger = logging.getLogger('replay')
>          vm = self.get_vm(name='record' if record else 'replay')
>          vm.set_console()
>          if record:
> -            logger.info('recording the execution...')
> +            logger.info('Recording the execution...')
>              mode = 'record'
>          else:
> -            logger.info('replaying the execution...')
> +            logger.info('Replaying the execution...')

This change isn't really needed imho.

>              mode = 'replay'
>              vm.add_args('-gdb', 'tcp::%d' % port, '-S')
>          vm.add_args('-icount', 'shift=%s,rr=%s,rrfile=%s,rrsnapshot=init' %
> @@ -52,145 +121,144 @@ def run_vm(self, record, shift, args, replay_path, image_path, port):
>          if args:
>              vm.add_args(*args)
>          vm.launch()
> -        console_drainer = datadrainer.LineLogger(vm.console_socket.fileno(),
> -                                    logger=self.log.getChild('console'),
> -                                    stop_check=(lambda : not vm.is_running()))
> -        console_drainer.start()

This is unrelated to gdbmi conversino, so can you drop the data drainer
stuff on its own, eg this patch

  https://lists.nongnu.org/archive/html/qemu-devel/2025-09/msg02501.html

> -        return vm
>  
> -    @staticmethod
> -    def get_reg_le(g, reg):
> -        res = g.cmd(b'p%x' % reg)
> -        num = 0
> -        for i in range(len(res))[-2::-2]:
> -            num = 0x100 * num + int(res[i:i + 2], 16)
> -        return num
> -
> -    @staticmethod
> -    def get_reg_be(g, reg):
> -        res = g.cmd(b'p%x' % reg)
> -        return int(res, 16)
> -
> -    def get_reg(self, g, reg):
> -        # value may be encoded in BE or LE order
> -        if self.endian_is_le:
> -            return self.get_reg_le(g, reg)
> -        else:
> -            return self.get_reg_be(g, reg)
> -
> -    def get_pc(self, g):
> -        return self.get_reg(g, self.REG_PC)
> -
> -    def check_pc(self, g, addr):
> -        pc = self.get_pc(g)
> -        if pc != addr:
> -            self.fail('Invalid PC (read %x instead of %x)' % (pc, addr))
> -
> -    @staticmethod
> -    def gdb_step(g):
> -        g.cmd(b's', b'T05thread:01;')
> -
> -    @staticmethod
> -    def gdb_bstep(g):
> -        g.cmd(b'bs', b'T05thread:01;')
> +        return vm
>  
>      @staticmethod
>      def vm_get_icount(vm):
>          return vm.qmp('query-replay')['return']['icount']
>  
>      def reverse_debugging(self, shift=7, args=None):
> -        from avocado.utils import gdb
> -        from avocado.utils import process
> -
>          logger = logging.getLogger('replay')
>  
> -        # create qcow2 for snapshots
> -        logger.info('creating qcow2 image for VM snapshots')
> +        # Create qcow2 for snapshots
> +        logger.info('Creating qcow2 image for VM snapshots')

Please avoid mixing in extra changes like this with other
functional refactoring, as it makes the diff larger and
harder to review. There's many more examples of changes
like this but I wouln't point them all out.  If you still
think this is beneficial, do it as a separate commit from
the functional changes.

>          image_path = os.path.join(self.workdir, 'disk.qcow2')
>          qemu_img = get_qemu_img(self)
>          if qemu_img is None:
>              self.skipTest('Could not find "qemu-img", which is required to '
>                            'create the temporary qcow2 image')
>          cmd = '%s create -f qcow2 %s 128M' % (qemu_img, image_path)
> -        process.run(cmd)
> +        r = subprocess.run(cmd, capture_output=True, shell=True, text=True)
> +        logger.info(r.args)
> +        logger.info(r.stdout)

Can you remove the 'process.run' in a separate commit, and use
check_output, rather than 'run', and avoid the use of shell.
ie this patch:

 https://lists.nongnu.org/archive/html/qemu-devel/2025-09/msg02500.html

>  
>          replay_path = os.path.join(self.workdir, 'replay.bin')
>  
> -        # record the log
> +        # Record the log.
>          vm = self.run_vm(True, shift, args, replay_path, image_path, -1)
>          while self.vm_get_icount(vm) <= self.STEPS:
>              pass
>          last_icount = self.vm_get_icount(vm)
>          vm.shutdown()
>  
> -        logger.info("recorded log with %s+ steps" % last_icount)
> +        logger.info("Recorded log with %s+ steps" % last_icount)
> +
> +        # Replay and run debug commands.
> +        gdb_cmd = os.getenv('QEMU_TEST_GDB')
> +        if not gdb_cmd:
> +            test.skipTest(f"Test skipped because there is no GDB available!")


This message doesn't tell the user what envrionment variable they
are missing.

Can you introduce a 'skipIfMissingEnv(envname)' decorator to
tests/functional/qemu_test/decorators.py, and then use it to
decorate the tests

>  
> -        # replay and run debug commands
>          with Ports() as ports:
>              port = ports.find_free_port()
>              vm = self.run_vm(False, shift, args, replay_path, image_path, port)


I'd suggest that at this point to start a new method

       try:
         logger.info('connecting to gdbstub')
         self.reverse_debugging_run(vm)
         logger.info('Test passed.')
       except GdbTimeoutError:
         self.fail("Connection to gdbstub timeouted...")

So we have a separation between the test bootstrap and the test
execution, with the added benefit that this patch won't bulk
re-indent everything below this point - the bulk re-indent makes
it hard to review this

> -        logger.info('connecting to gdbstub')
> -        g = gdb.GDBRemote('127.0.0.1', port, False, False)
> -        g.connect()
> -        r = g.cmd(b'qSupported')
> -        if b'qXfer:features:read+' in r:
> -            g.cmd(b'qXfer:features:read:target.xml:0,ffb')
> -        if b'ReverseStep+' not in r:
> -            self.fail('Reverse step is not supported by QEMU')
> -        if b'ReverseContinue+' not in r:
> -            self.fail('Reverse continue is not supported by QEMU')
> -
> -        logger.info('stepping forward')
> -        steps = []
> -        # record first instruction addresses
> -        for _ in range(self.STEPS):
> -            pc = self.get_pc(g)
> -            logger.info('saving position %x' % pc)
> -            steps.append(pc)
> -            self.gdb_step(g)
> -
> -        # visit the recorded instruction in reverse order
> -        logger.info('stepping backward')
> -        for addr in steps[::-1]:
> -            self.gdb_bstep(g)
> -            self.check_pc(g, addr)
> -            logger.info('found position %x' % addr)
> -
> -        # visit the recorded instruction in forward order
> -        logger.info('stepping forward')
> -        for addr in steps:
> -            self.check_pc(g, addr)
> -            self.gdb_step(g)
> -            logger.info('found position %x' % addr)
> -
> -        # set breakpoints for the instructions just stepped over
> -        logger.info('setting breakpoints')
> -        for addr in steps:
> -            # hardware breakpoint at addr with len=1
> -            g.cmd(b'Z1,%x,1' % addr, b'OK')
> -
> -        # this may hit a breakpoint if first instructions are executed
> -        # again
> -        logger.info('continuing execution')
> -        vm.qmp('replay-break', icount=last_icount - 1)
> -        # continue - will return after pausing
> -        # This could stop at the end and get a T02 return, or by
> -        # re-executing one of the breakpoints and get a T05 return.
> -        g.cmd(b'c')
> -        if self.vm_get_icount(vm) == last_icount - 1:
> -            logger.info('reached the end (icount %s)' % (last_icount - 1))
> -        else:
> -            logger.info('hit a breakpoint again at %x (icount %s)' %
> -                        (self.get_pc(g), self.vm_get_icount(vm)))
>  
> -        logger.info('running reverse continue to reach %x' % steps[-1])
> -        # reverse continue - will return after stopping at the breakpoint
> -        g.cmd(b'bc', b'T05thread:01;')
> +        try:
> +            gdb = GDB(gdb_cmd)
>  
> -        # assume that none of the first instructions is executed again
> -        # breaking the order of the breakpoints
> -        self.check_pc(g, steps[-1])
> -        logger.info('successfully reached %x' % steps[-1])
> +            logger.info('Connecting to gdbstub...')
>  
> -        logger.info('exiting gdb and qemu')
> -        vm.shutdown()
> +            gdb.cli("set debug remote 1")
> +
> +            c = gdb.cli(f"target remote localhost:{port}").get_console()
> +            if not f"Remote debugging using localhost:{port}" in c:
> +                self.fail("Could not connect to gdbstub!")
> +
> +            # Remote debug messages are in 'log' payloads.
> +            r = gdb.get_log()
> +            if 'ReverseStep+' not in r:
> +                self.fail('Reverse step is not supported by QEMU')
> +            if 'ReverseContinue+' not in r:
> +                self.fail('Reverse continue is not supported by QEMU')
> +
> +            gdb.cli("set debug remote 0")
> +
> +            logger.info('Stepping forward')
> +            steps = []
> +            # Record first instruction addresses.
> +            for _ in range(self.STEPS):
> +                pc = gdb.cli("print $pc").get_addr()
> +                logger.info('Saving position %x' % pc)
> +                steps.append(pc)
> +
> +                gdb.cli("stepi")
> +
> +            # Visit the recorded instructions in reverse order.
> +            logger.info('Stepping backward')
> +            for saved_pc in steps[::-1]:
> +                logger.info('Found position %x' % saved_pc)
> +                gdb.cli("reverse-stepi")
> +                pc = gdb.cli("print $pc").get_addr()
> +                if pc != saved_pc:
> +                    logger.info('Invalid PC (read %x instead of %x)' % (pc, saved_pc))
> +                    self.fail('Reverse stepping failed!')
> +
> +            # Visit the recorded instructions in forward order.
> +            logger.info('Stepping forward')
> +            for saved_pc in steps:
> +                logger.info('Found position %x' % saved_pc)
> +                pc = gdb.cli("print $pc").get_addr()
> +                if pc != saved_pc:
> +                    logger.info('Invalid PC (read %x instead of %x)' % (pc, saved_pc))
> +                    self.fail('Forward stepping failed!')
> +
> +                gdb.cli("stepi")
> +
> +            # Set breakpoints for the instructions just stepped over.
> +            logger.info('Setting breakpoints')
> +            for saved_pc in steps:
> +                gdb.cli(f"break *{hex(saved_pc)}")
> +
> +            # This may hit a breakpoint if first instructions are executed again.
> +            logger.info('Continuing execution')
> +            vm.qmp('replay-break', icount=last_icount - 1)
> +            # continue - will return after pausing.
> +            # This can stop at the end of the replay-break and gdb gets a SIGINT,
> +            # or by re-executing one of the breakpoints and gdb stops at a
> +            # breakpoint.
> +            gdb.cli("continue")
> +
> +            pc = gdb.cli("print $pc").get_addr()
> +            current_icount = self.vm_get_icount(vm)
> +            if current_icount == last_icount - 1:
> +                print(f"# **** Hit replay-break at icount={current_icount}, pc={hex(pc)} ****")
> +                logger.info('Reached the end (icount %s)' % (current_icount))
> +            else:
> +                print(f"# **** Hit breakpoint at icount={current_icount}, pc={hex(pc)} ****")
> +                logger.info('Hit a breakpoint again at %x (icount %s)' %
> +                            (pc, current_icount))
> +
> +            logger.info('Running reverse continue to reach %x' % steps[-1])
> +            # reverse-continue - will return after stopping at the breakpoint.
> +            gdb.cli("reverse-continue")
> +
> +            # Assume that none of the first instructions are executed again
> +            # breaking the order of the breakpoints.
> +            # steps[-1] is the first saved $pc in reverse order.
> +            pc = gdb.cli("print $pc").get_addr()
> +            first_pc_in_rev_order = steps[-1]
> +            if pc == first_pc_in_rev_order:
> +                print(f"# **** Hit breakpoint at the first PC in reverse order ({hex(pc)}) ****")
> +                logger.info('Successfully reached breakpoint at %x' % first_pc_in_rev_order)
> +            else:
> +                logger.info('Failed to reach breakpoint at %x' % first_pc_in_rev_order)
> +                self.fail("'reverse-continue' did not hit the first PC in reverse order!")
> +
> +            logger.info('Exiting GDB and QEMU...')
> +            gdb.exit()
> +            vm.shutdown()
> +
> +            logger.info('Test passed.')
> +
> +        except GdbTimeoutError:
> +            self.fail("Connection to gdbstub timeouted...")
> -- 
> 2.34.1
> 

With regards,
Daniel
-- 
|: https://berrange.com      -o-    https://www.flickr.com/photos/dberrange :|
|: https://libvirt.org         -o-            https://fstop138.berrange.com :|
|: https://entangle-photo.org    -o-    https://www.instagram.com/dberrange :|


